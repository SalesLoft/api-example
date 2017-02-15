# SalesLoft API

SalesLoft API provides an easy REST-ful way to programmatically interact with your SalesLoft
instance data. After using OAuth 2.0 to authorize an account, the REST API is accessed over
HTTP to push and pull data from SalesLoft. The SalesLoft API is documented at
https://sdr.salesloft.com/swagger/index.html.

## Getting Started

This repository provides a very simple Ruby based exploration of the API. The flow is broken down
into 2 stages:

1. Authorize your SalesLoft account through a Sinatra web server
2. Run a cli script that interacts with your data, creating a person and adding them to a cadence.

Before you can get started with this example, you'll need to obtain an API token from SalesLoft. This
can be done by emailing integrations at salesloft dot com. You will need a redirect uri to do so. Please
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

## Questions

Please email integrations at salesloft dot com to get started with the SalesLoft API and with any questions you have.
