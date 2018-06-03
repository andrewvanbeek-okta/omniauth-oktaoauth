# omniauth-oktaoauth OmniAuth Okta OAuth2 Strategy


Continues the great work done by Danandrews at the original repo: https://github.com/dandrews/omniauth-oktaoauth.

This newer version now supports options for Okta's Api Access Management and Custom Oauth Tokens and Urls.  Important to note that is this not an officially released tool and maybe subject to change.



This strategy can both use Okta's OIDC and Api Access Management Flows. See [developer docs](https://developer.okta.com/docs/api/resources/oidc.html) for more details.

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

### Environment Variables

```bash
OKTA_CLIENT_ID     # required
OKTA_CLIENT_SECRET # required
# optional - defaults to 'okta.com' if unset
required client options are
site: "your okta org or full issuer with okta"
authorize_url: "your authorization url"
token_url: "your token url"

These end points for custom auth servers can be found at {your okta org or custom url}/oauth2/{your server id}/.well-known/oauth-authorization-server

For Oidc only it is {your okta org or custom url}/.well-known/openid-configuration



### Devise

Here is an example with Devise in `config/initializers/devise.rb`.

Configuration options can be passed as the last parameter here as key/value pairs.

or add options like the following:

```ruby
  require 'omniauth-oktaoauth'
  config.omniauth(:oktaoauth,
                ENV['OKTA_CLIENT_ID'],
                ENV['OKTA_CLIENT_SECRET'],
                :scope => 'openid profile email',
                :fields => ['profile', 'email'],
                :client_options => {site: ENV['OKTA_ISSUER'], authorize_url: ENV['OKTA_ISSUER'] + "/v1/authorize", token_url: ENV['OKTA_ISSUER'] + "/v1/token"},
                :redirect_uri => ENV["OKTA_REDIRECT_URI"],
                :auth_server_id => ENV['OKTA_AUTH_SERVER_ID'],
                :issuer => ENV['OKTA_ISSUER'],
                :strategy_class => OmniAuth::Strategies::Oktaoauth)
```

Then add the following to 'config/routes.rb' so the callback routes are defined.

```ruby
devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
```

Make sure your model is omniauthable. Generally this is "/app/models/user.rb"

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
