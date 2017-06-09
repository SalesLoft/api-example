# SalesLoft API

SalesLoft API provides an easy REST-ful way to programmatically interact with your SalesLoft
instance data. After using OAuth 2.0 to authorize an account, the REST API is accessed over
HTTP to push and pull data from SalesLoft. The SalesLoft API is documented at
https://api.salesloft.com/swagger/index.html.

## Getting Started

This repository provides a very simple Ruby based exploration of the API. The flow is broken down
into 2 stages:

1. Authorize your SalesLoft account through a Sinatra web server
2. Run a cli script that interacts with your data, creating a person and adding them to a cadence.

Before you can get started with this example, you'll need to obtain an API token from SalesLoft. This
can be done by emailing [support@salesloft.com](mailto:support@salesloft.com). You will need a redirect uri to do so. Please
provide `https://localhost:8443` if you want to authorize this example code.

## Running Server to Authorize

In order to go through the OAuth 2.0 flow, an http server must be involved. This is provided through a
Sinatra application `server.rb` that is started with:

```
SALESLOFT_APP_ID=your_id SALESLOFT_APP_SECRET=your_secret ruby server.rb
```

Proceed to https://localhost:8443 (you may need to authorize the SSL certificate manually) and click
login with SalesLoft. The url will change to https://localhost:8443?success if this worked.

## Running CLI Demo

The CLI demo `cli.rb` hits a few of our API endpoints. It also shows how to manage your refresh token
so that you don't need to re-authorize an account when the access token expires. The CLI is started with:

```
SALESLOFT_APP_ID=your_id SALESLOFT_APP_SECRET=your_secret ruby cli.rb
```

You will see some output from this indicating the result of the API calls.

## Credentials Stored Locally

Your credentials are stored in a YAML::Store instance `credentials.store`. Do not share these credentials with
anyone as they can be used to access your account; the file is in .gitignore. Treat them as you would a password.
If you store credentials on your server, please do so in a secure manner.

## How do I get started?

Please email [support@salesloft.com](mailto:support@salesloft.com) to get started with the SalesLoft API and with any questions you have.

## SalesLoft Basic Resources

The following are core resources that the SalesLoft API exposes. All resources are listed in detail on our [documentation](https://api.salesloft.com/swagger/index.html).

### [Person](https://api.salesloft.com/swagger/index.html#!/People/PublicApi_V1_People_create)

A Person is an instance of an individual that is being reached out to through the SalesLoft platform. Users can email, call, and execute social steps on people.

The SalesLoft API provides endpoints to get, create, and update single Person objects.

### [Cadence](https://api.salesloft.com/swagger/index.html#!/Cadences/PublicApi_V1_Cadences_index)

A Cadence is the definition of how communication happens. An example Cadence could be "7x7" where 7 touches happen over 7 days. This example Cadence might consist of call, email, or other steps.

The SalesLoft API provides endpoints to list all cadences for a user or for the team (requires admin OAuth connection). The [PersonCadenceMembership](https://api.salesloft.com/swagger/index.html#!/Person_Cadence_Memberships/PublicApi_V1_PersonCadenceMemberships_index) is used to add a Person to a Cadence.

### [Company](https://api.salesloft.com/swagger/index.html#!/Companies/PublicApi_V1_Companies_create)

A Company contains information about the company that people work for. Companies consist of not only information about the company, but also about the people who work for the company.

The SalesLoft API provides endpoints to get, create, and update single Company objects. A Person's Company can be changed by setting the `company_id` attribute on the [Person update request](https://api.salesloft.com/swagger/index.html#!/People/PublicApi_V1_People_update).
