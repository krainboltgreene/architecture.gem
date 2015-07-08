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

Architecture's main goal is to become the library of choice for gems like rake and thor.


Using
=====

Using the DSL you can:

``` ruby
require "architecture/dsl"

architecture source: "old", destination: "new"  do |arc|
  # Filesystem transactions here, see below
end
```

**Copy Operation**

``` ruby
# Copy a file OR directory:
arc.copy file: "README.md"
arc.copy directory: "docs"

# Copy over a file OR directory with a new name:
arc.copy file: "LICENSE", as: "COPYRIGHT"
arc.copy directory: "test", as: "spec"

# Copy over a file with context:
arc.copy file: "app.rb", context: { module: "Foobar" }

#> old/application.rb
# module {{module}}
#
# end
#
#> new/application.rb
# module Foobar
#
# end
```


**Create Operation**

``` ruby
# Create a file OR directory in the destination:
arc.create file: "app.rb"
arc.create directory: "lib"

# Create a file with content in the destination:
arc.create file: "app.rb", content: "Some thing."

# Create a file with some embedded context in the destination:
arc.create file: "app.rb", content: "Some {{foo}}.", context: { foo: "thing." }

# Create a directory in the destination and work within it:
arc.create directory: "lib" do |arc|
  arc.create file: "project.rb"
end

# Create a file OR directory in a specific location:
arc.create file: "dev.txt", location: "/var/logs"
arc.create directory: "output/", location: arc.join(arc.source, "tmp")
```


**Delete Operation**

``` ruby
# Delete a file or directory in the destination:
arc.delete file: "app.rb"
arc.delete directory: "app"

# Delete a file OR directory in a specific directory:
arc.delete file: "dev.txt", location: "/var/logs"
arc.delete directory: "output/", location: arc.join(arc.source, "tmp")
```


**Move Operation**

``` ruby
# Move a file or directory:
arc.move file: "app.rb", as: "app.rb"
arc.move directory: "app.rb", as: "app.rb"
```


**Overwrite Operation**

``` ruby
# Write over a file:
arc.overwrite file: "app.rb", content: "\n"

# Overwrite content in a file in a specific directory:
arc.overwrite file: "dev.txt", content: "\n", location: "/var/logs"
arc.overwrite file: "dev.txt", content: "\n", location: arc.join(arc.source, "logs")
```


**Append Operation**

``` ruby
arc.append file: "app.rb", content: "end"

# Append content in a file in a specific directory:
arc.append file: "dev.txt", content: "+", location: "/var/logs"
arc.append file: "dev.txt", content: "+", location: arc.join(arc.source, "logs")
```


**Prepend Operation**

``` ruby
arc.prepend file: "app.rb", content: "class Foobaz"

# Prepend content in a file in a specific directory:
arc.prepend file: "dev.txt", content: "-", location: "/var/logs"
arc.prepend file: "dev.txt", content: "-", location: arc.join(arc.source, "logs")
```


**Replace Operation**

``` ruby
arc.replace file: "app.rb", search: /Foobaz/, content: "Foobar"

# Replace content in a file in a specific directory:
arc.replace file: "dev.txt", search: /a/, content: "b", location: "/var/logs"
arc.replace file: "dev.txt", search: /a/, content: "b", location: arc.join(arc.source, "logs")
```


**Within Scope**

``` ruby
arc.within "folder" do |arc|
  arc.create name: "version.rb", content: "VERSION = 1.0.0"
end

arc.within source: "/var", destination: "/tmp" do |arc|
  arc.create name: "version.rb", content: "VERSION = 1.0.0"
end
```


Installing
==========

Add this line to your application's Gemfile:

    gem "architecture", "6.0.2"

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

  - 6.0.2: Fixing indentation level of within blocks
  - 6.0.1:
    - Accidentally forgot to pass the block to create/move/copy, woops
    - Forgot to define the to_s of entity
    - Fixing typo in readme
  - 6.0.0:
    * Added logging for the DSL layer
    * Extracted Entity from Transactions
    * Added 'within' capability to create/copy/move
    * Added a location option for targeted transactions, so things don't need to be scoped
  - 5.2.1: Fixed a bug with `within` DSL.
  - 5.2.0:
    * Finally got around to writing tests for `Entity`
    * Fixed a bug where it was reading from an old ivar
    * Allowed an engine to be used on an Entity, internally at least
  - 5.1.2: Fixing an issue where path was not set in a Entity.
  - 5.1.1:
    * The `create` dsl method now defaults to as, then file/directory.
    * `move` no longer path scopes the `as:` value.
  - 5.1.0:
    * Making the `copy` & `move` dsl methods use the same file/directory syntax
    * Updating the readme documentation to match the new scoping rules
    * Fixing a problem with within not using the right argument name
  - 5.0.0: Making the private methods public, a fix for when we went to scoped.
  - 4.0.0: Making each block have a scope object.
  - 3.0.0: Removing the `architecture` method from `Object`
  - 2.0.1: Added mustache as a runtime, instead of development dependency
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
