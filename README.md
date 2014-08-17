# Rubotium

This is an Android's Instrumentation test runner. It's in quite early phase but already solves couple of issues with instrumentation tests: 
 
 * runs tests in parallel
 * retries failed tests
 * does execute all the package tests even if the app dies during the execution

## Installation

    gem install rubotium

## Usage

    $ rubotium -t <path_to_tests.apk> -a <path_to_application.apk> -r <instrumentation_test_runner>
    $ rubotium -h for help

## Contributing

1. Fork it ( http://github.com/<my-github-username>/rubotium/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
