[![Build Status](https://travis-ci.org/ssmiech/rubotium.svg?branch=master)](https://travis-ci.org/ssmiech/rubotium)
[![Code Climate](https://codeclimate.com/github/ssmiech/rubotium/badges/gpa.svg)](https://codeclimate.com/github/ssmiech/rubotium)
[![Coverage Status](https://coveralls.io/repos/ssmiech/rubotium/badge.svg?branch=master)](https://coveralls.io/r/ssmiech/rubotium?branch=master)

# Rubotium

This is an Android's Instrumentation test runner. It's in quite early phase but already solves couple of issues with instrumentation tests: 
 
 * runs tests in parallel
 * retries failed tests
 * does execute all the package tests even if the app dies during the execution

## Installation

    gem install rubotium

## Requirements:
 Installed android SDK with `aapt` in your PATH 
 Installed `java` with `javap` in your PATH
## Usage

    $ rubotium -t <path_to_tests.apk> -a <path_to_application.apk> -r <instrumentation_test_runner>
    $ rubotium -h for help

## Contributing

1. Fork it ( http://github.com/<my-github-username>/rubotium/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
