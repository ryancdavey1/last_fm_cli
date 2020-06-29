# LastFM CLI

This gem utilizes the `https://www.last.fm/api/show/chart.getTopTracks` endpoint from last.fm to display the top 50 music tracks in the api. The user can list the songs, display individual song details, and add a selected song to the current playlist.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'last_fm_cli'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install last_fm_cli

## Usage

Run `./bin/last_fm_cli` to initiate the last.fm cli

Enter `tracks` to display the list of the current top 50 tracks in the music chart.
  - Enter a number 1 to 50 to select a song from the list.
  - After selecting a number, enter `add song` to add the song to the current playlist.
  - To reset the currently selected song, enter `tracks`.
Enter `playlist` to display the current list of songs in the playlist.
Enter `artists` to display the artists that are currently featured in the music chart.
  - Enter `exit` to quit the program.


## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/'adventurous-actor-6061'/last_fm_cli. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the LastFmCli project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/'adventurous-actor-6061'/last_fm_cli/blob/master/CODE_OF_CONDUCT.md).
