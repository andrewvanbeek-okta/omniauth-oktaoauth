# omniauth-oktaoauth OmniAuth Okta OAuth2 Strategy

This gem continued the great work done by Danandrews in [`omniauth-okta`](https://github.com/dandrews/omniauth-okta).  But honestly their gem is more updated so please use that one.  Also not an official sdk from Okta.

This newer version now supports options for Okta's API Access Management and Custom Oauth Tokens and URLs. 

_Note: This is not as of yet a fully officially released tool and maybe subject to changes. Feel free to use or improve on it!_

To see it in action check out the example app: https://github.com/andrewvanbeek-okta/oktaOmniauthDeviseSample

This strategy can both use Okta's OpenID Connect and API Access Management Flows. See [developer docs](https://developer.okta.com/docs/api/resources/oidc.html) for more details.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'omniauth-oktaoauth'
```

And then execute:
```bash
$ bundle install
```

Or install it yourself as:
```bash
$ gem install omniauth-oktaoauth
```

### Devise

For OpenID Connect only, it is `{your okta org or custom url}/.well-known/openid-configuration`.

The endpoints for custom auth servers can be found at `{your okta org or custom url}/oauth2/{your server id}/.well-known/oauth-authorization-server`. 

> :bulb: **Protip** Save yourself time and look at these URLS. They return a JSON blob that will give you the info you need to fill in the devise settings.


Here is an example with Devise in `config/initializers/devise.rb`:

```ruby
config.omniauth(:oktaoauth, ENV['OKTA_CLIENT_ID'], ENV['OKTA_CLIENT_SECRET'],
  scope: 'openid profile email',
  fields: ['profile', 'email'],
  client_options: {
    site: ENV['OKTA_ISSUER'],
    authorize_url: ENV['OKTA_ISSUER'] + "/v1/authorize",
    token_url: ENV['OKTA_ISSUER'] + "/v1/token"
   },
  redirect_uri: ENV["OKTA_REDIRECT_URI"],
  auth_server_id: ENV['OKTA_AUTH_SERVER_ID'],
  issuer: ENV['OKTA_ISSUER'],
  strategy_class: OmniAuth::Strategies::Oktaoauth)
```

Add the following to 'config/routes.rb' to define the callback routes:

```ruby
devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
```

Make sure your model is omniauthable. Generally this is done in "/app/models/user.rb":

```ruby
devise :omniauthable, omniauth_providers: [:oktaoauth]
```

## Auth Hash

Here's an example of an authentication hash available in the callback by accessing `request.env['omniauth.auth']`:

```ruby
{
  "provider" => "okta",
  "uid" => "0000000000000001",
  "info" => {
    "name" => "John Smith",
    "email" => "john@example.com",
    "first_name" => "John",
    "last_name" => "Smith",
    "image" => "https://photohosting.com/john.jpg"
  },
  "credentials" => {
    "token" => "TOKEN",
    "expires_at" => 1496617411,
    "expires" => true
  },
  "extra" => {
    "raw_info" => {
      "sub" => "0000000000000001",
      "name" => "John Smith",
      "locale" => "en-US",
      "email" => "john@example.com",
      "picture" => "https://photohosting.com/john.jpg",
      "website" => "https://example.com",
      "preferred_username" => "john@example.com",
      "given_name" => "John",
      "family_name" => "Smith",
      "zoneinfo" => "America/Los_Angeles",
      "updated_at" => 1496611646,
      "email_verified" => true
    },
    "id_token" => "TOKEN",
    "id_info" => {
      "ver" => 1,
      "jti" => "AT.D2sslkfjdsldjf899n090sldkfj",
      "iss" => "https://your-org.okta.com",
      "aud" => "https://your-org.okta.com",
      "sub" => "john@example.com",
      "iat" => 1496613811,
      "exp" => 1496617411,
      "cid" => "CLIENT_ID",
      "uid" => "0000000000000001",
      "scp" => ["email", "profile", "openid"]
    }
  }
}
```


## License
The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
