# Macvendors

A command line tool to find vendor name from a mac address.

No need for an external api. You can also extend it in your ruby code.

# How mac address works?

Source: [Hastur](http://superuser.com/users/257269/hastur) http://superuser.com/a/1093431

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'macvendors'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install macvendors

## Usage


  ### Command line

```
  macvendors find 98:e0:d9:a5:61:eb
  > Apple, Inc.

  macvendors update
  > oui.csv removed.
  > downloaded oui.csv
```

  ### Ruby

  ```
  require 'macvendors'

  puts MacVendors.find("98:e0:d9:a5:61:eb")

  MacVendors.update() //update the oui file

  ```


## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/macvendors. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
