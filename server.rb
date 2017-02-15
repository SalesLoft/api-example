require 'rubygems'
require 'bundler/setup'
Bundler.require(:default)
require 'sinatra'
require 'yaml/store'
require_relative 'server/server_ssl'

use Rack::Session::Cookie
use OmniAuth::Builder do
  provider :salesloft, ENV.fetch('SALESLOFT_APP_ID'), ENV.fetch('SALESLOFT_APP_SECRET')
end

set :port, 8443

get '/' do
  <<-HTML
  <a href='/auth/salesloft'>Sign in with SalesLoft</a>
  HTML
end

get '/auth/failure' do
  request.inspect
end

get '/auth/salesloft/callback' do
  credentials = request.env['omniauth.auth'][:credentials]
  store = YAML::Store.new "credentials.store"
  store.transaction do
    store[:credentials] = credentials.to_h
  end
  redirect '/?success'
end
