# Lotrb

This library provide a Ruby SDK to [The One API](https://the-one-api.dev/), a rich API for fetching information about the Lord of the Rings books and movies.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'lotrb'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install lotrb

## Usage

Before using this library, you'll need to provision an access token for The One API by [signing up](https://the-one-api.dev/sign-up). Then, you will need to configure this library with your access token.

Set `Lotrb.access_token` to the value of your token:

```ruby
require "lotrb"

Lotrb.access_token = "your_access_token_here"

# List all the movies
Lotrb::Movie.list()

# Fetch a specific movie
Lotrb::Movie.retrieve("some_movie_id")
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/lotrb. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/[USERNAME]/lotrb/blob/main/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Lotrb project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/lotrb/blob/main/CODE_OF_CONDUCT.md).
