require 'rubygems'
require 'bundler/setup'
Bundler.require(:default)

require_relative 'cli/refresh_token'
require_relative 'cli/store'
require_relative 'cli/token'
require_relative 'cli/simple_api'

token = Token.new
api = SimpleApi.new(token: token)

# Show who the authorized user is
me = api.me
puts "Authorization:"
puts "\tYou are authorized as #{me["email"]}"

# Create a fake person for the current user
unique_fake_safe_email = me["email"].split("@").join("+#{Time.now.to_i}@")
person = api.create_person(email_address: unique_fake_safe_email)

puts "Person Creation:"
puts "\tPerson #{person["id"]} was created with email #{person["email_address"]}"
puts "\tYou can view this person at #{api.person_url(person["id"])}"

# Update the person's name
updated_person = api.update_person(person["id"], first_name: "Test", last_name: "McTester")
puts "Person Updating:"
puts "\tPerson #{person["id"]} was updated to have a different name."

# Find the person by email
email_lookup_person = api.get_person(person["email_address"])
puts "Person email lookup:"
puts "\tPeople can be looked up by their email address, like #{email_lookup_person["id"]} was just looked up."

# Add the person to the cadence
cadences = api.cadences
puts "Add person to cadence:"
if cadences.any?
  added_person = api.add_person_to_cadence(person["id"], cadences[0]["id"])
  if added_person["person_id"]
    puts "\tPerson #{added_person["person_id"]} added to cadence #{added_person["cadence_id"]}."
    puts "\tView this cadence's people at #{api.cadence_people_url(added_person["cadence_id"])}"
  else
    puts "\tOops, this person could not be added."
  end
else
  puts "\tYou must create a cadence in app before you can add a person to a cadence"
end
