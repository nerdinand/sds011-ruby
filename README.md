# sds011-ruby

Ruby code to read data from an SDS011 particulate matter sensor

## Usage

This assumes Ruby is installed.

1. `git clone git@github.com:nerdinand/sds011-ruby.git && cd sds011-ruby`
2. `bundle install`
3. `ruby sds011.rb`

*Note:* You probably have to adapt the serial port on which your sensor is connected (see `sds101.rb`).

Tested on macOS Mojave 10.14.4, but should work on Linux too. No clue about Windows... ;-)

## License

Licensed under MIT license: https://opensource.org/licenses/MIT
