## Stecms Api Ecommerces

This plugin provide feature for managing data request data from ecommerces list for STECMS.

## Installation
Add this line to your application's Gemfile:
```ruby
gem 'stecms_api_ecommerce', github: 'LipsiaGROUP/stecms_api_ecommerce'
gem 'rest-client'
gem 'kaminari'
```

And then execute:

    $ bundle

## Usage

Run this command to generate required migration:
```ruby
 rake stecms_api_ecommerce:install:migrations
```

and then `rake db:migrate`

## Routes
Add this line to your application's routes.rb:
```ruby
  stecme_api_ecommerce
```

##  Menu View

Run this command to generate default:
```ruby
 rake stecms_api_ecommerce:menu_admin
```
