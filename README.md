architecture
------------

  - [![Quality](http://img.shields.io/codeclimate/github/krainboltgreene/architecture.gem.svg?style=flat-square)](https://codeclimate.com/github/krainboltgreene/architecture.gem)
  - [![Coverage](http://img.shields.io/codeclimate/coverage/github/krainboltgreene/architecture.gem.svg?style=flat-square)](https://codeclimate.com/github/krainboltgreene/architecture.gem)
  - [![Build](http://img.shields.io/travis-ci/krainboltgreene/architecture.gem.svg?style=flat-square)](https://travis-ci.org/krainboltgreene/architecture.gem)
  - [![Dependencies](http://img.shields.io/gemnasium/krainboltgreene/architecture.gem.svg?style=flat-square)](https://gemnasium.com/krainboltgreene/architecture.gem)
  - [![Downloads](http://img.shields.io/gem/dtv/architecture.svg?style=flat-square)](https://rubygems.org/gems/architecture)
  - [![Tags](http://img.shields.io/github/tag/krainboltgreene/architecture.gem.svg?style=flat-square)](http://github.com/krainboltgreene/architecture.gem/tags)
  - [![Releases](http://img.shields.io/github/release/krainboltgreene/architecture.gem.svg?style=flat-square)](http://github.com/krainboltgreene/architecture.gem/releases)
  - [![Issues](http://img.shields.io/github/issues/krainboltgreene/architecture.gem.svg?style=flat-square)](http://github.com/krainboltgreene/architecture.gem/issues)
  - [![License](http://img.shields.io/badge/license-MIT-brightgreen.svg?style=flat-square)](http://opensource.org/licenses/MIT)
  - [![Version](http://img.shields.io/gem/v/architecture.svg?style=flat-square)](https://rubygems.org/gems/architecture)


Architecture is a library that makes scaffolding and file manipulation easy. It gives you a programatic interface and DSL for creating, copying, moving, "rendering", & deleting files and directories.

Architecture's main goal is to become the library of choice for gems like rake
and thor.


Using
=====

Using the DSL you can:

``` ruby
require "architecture/dsl"

architecture source: "old", destination: "new"  do
  # Copy a file or directory:
  copy name: "README.md"

  # Rename a copied file or directory:
  copy name: "LICENSE", as: "COPYRIGHT"

  # Render a file:
  # - old/applicaiton.rb
  # module {{module}}
  #
  # end
  copy name: "app.rb", context: { module: "Foobar" }
  # - new/application.rb
  # module Foobar
  #
  # end

  # Delete a file or directory:
  delete file: "app.rb"
  delete directory: "app"

  # Create a file:
  create file: "app.rb", content: "Some {{foo}}.", context: { foo: "Bar" }

  # Create a directory:
  create directory: "lib"

  # Anything with the `path` keyword might need scoping:
  create file: source("app.rb")
  # - old/application.rb

  delete file: destiantion("app.rb")
  # - new/app.rb

  # Move a file or directory:
  move name: destination("app.rb"), as: destination("app.rb")

  # Write over a file:
  overwrite file: destination("app.rb"), content: "\n"

  # Append text to a file:
  append file: destination("app.rb"), content: "end"

  # Prepend text to a file:
  prepend file: destination("app.rb"), content: "class Foobaz"

  # Replace content in a file:
  replace file: destination("app.rb"), search: /Foobaz/, content: "Foobar"

  # Change the context of a series of commands:
  within source: File.join("lib", "foobar"), destination: File.join("lib", "foozball") do
    # Now source() returns `"old/lib/foobar"`
    # Now destination() returns `"new/lib/foozball"`
    create name: "version.rb", content: "VERSION = 1.0.0"
  end
end
```


Installing
==========

Add this line to your application's Gemfile:

    gem "architecture", "~> 1.0"

And then execute:

    $ bundle

Or install it yourself with:

    $ gem install architecture


Contributing
============

  1. Read the [Code of Conduct](/CONDUCT.md)
  2. Fork it
  3. Create your feature branch (`git checkout -b my-new-feature`)
  4. Commit your changes (`git commit -am 'Add some feature'`)
  5. Push to the branch (`git push origin my-new-feature`)
  6. Create new Pull Request


Changelog
=========

  - 2.0.0: Cleaned up a lot of the DSL api to make it easier to understand.
  - 1.1.0: Adding the Create functionality (woops)
  - 1.0.0: Initial release


License
=======

Copyright (c) 2015 Kurtis Rainbolt-Greene

MIT License

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
"Software"), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
