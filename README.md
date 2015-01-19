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

architecture source: "old", destination: "new"  do |architect|
  # Copy a file or directory:
  architect.copy name: "README.md"

  # Rename a copied file or directory:
  architect.copy name: "LICENSE", as: "COPYRIGHT"

  # Render a file:
  # - old/applicaiton.rb
  # module {{module}}
  #
  # end
  architect.copy name: "app.rb", context: { module: "Foobar" }
  # - new/application.rb
  # module Foobar
  #
  # end

  # Delete a file or directory:
  architect.delete file: "app.rb"
  architect.delete directory: "app"

  # Create a file:
  architect.create file: "app.rb", content: "Some {{foo}}.", context: { foo: "Bar" }

  # Create a directory:
  architect.create directory: "lib"

  # Anything with the `file` or `directory` keyword might need scoping:
  architect.create file: architect.source("app.rb")
  # - old/application.rb

  architect.delete file: architect.destiantion("app.rb")
  # - new/app.rb

  # Move a file or directory:
  architect.move name: architect.destination("app.rb"), as: architect.destination("app.rb")

  # Write over a file:
  architect.overwrite file: architect.destination("app.rb"), content: "\n"

  # Append text to a file:
  architect.append file: architect.destination("app.rb"), content: "end"

  # Prepend text to a file:
  architect.prepend file: architect.destination("app.rb"), content: "class Foobaz"

  # Replace content in a file:
  architect.replace file: architect.destination("app.rb"), search: /Foobaz/, content: "Foobar"

  # Change the context of a series of commands:
  architect.within source: File.join("lib", "foobar"), destination: File.join("lib", "foozball") do |scope|
    # Now architect.source() returns `"old/lib/foobar"`
    # Now architect.destination() returns `"new/lib/foozball"`
    scope.create name: "version.rb", content: "VERSION = 1.0.0"
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

  1. Fork it
  2. Create your feature branch (`git checkout -b my-new-feature`)
  3. Commit your changes (`git commit -am 'Add some feature'`)
  4. Push to the branch (`git push origin my-new-feature`)
  5. Create new Pull Request


Changelog
=========

  - 2.0.0: Cleaned up a lot of the DSL api to make it easier to understand.
  - 1.1.0: Adding the Create functionality (woops)
  - 1.0.0: Initial release


Conduct
=======

As contributors and maintainers of this project, we pledge to respect all people who contribute through reporting issues, posting feature requests, updating documentation, submitting pull requests or patches, and other activities.

We are committed to making participation in this project a harassment-free experience for everyone, regardless of level of experience, gender, gender identity and expression, sexual orientation, disability, personal appearance, body size, race, ethnicity, age, or religion.

Examples of unacceptable behavior by participants include the use of sexual language or imagery, derogatory comments or personal attacks, trolling, public or private harassment, insults, or other unprofessional conduct.

Project maintainers have the right and responsibility to remove, edit, or reject comments, commits, code, wiki edits, issues, and other contributions that are not aligned to this Code of Conduct. Project maintainers who do not follow the Code of Conduct may be removed from the project team.

This code of conduct applies both within project spaces and in public spaces when an individual is representing the project or its community.

Instances of abusive, harassing, or otherwise unacceptable behavior may be reported by opening an issue or contacting one or more of the project maintainers.

This Code of Conduct is adapted from the [Contributor Covenant](http://contributor-covenant.org), version 1.1.0, available at [http://contributor-covenant.org/version/1/1/0/](http://contributor-covenant.org/version/1/1/0/)


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
