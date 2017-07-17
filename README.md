## R2

Library for swapping CSS values for right-to-left display. A direct Ruby port of the Javascript/Node project at https://github.com/ded/R2.

## Installation

    $ gem install r2

## Usage

You can use the handy static method for flipping any CSS string via:

    > R2.r2("/* Comment */\nbody { direction: rtl; }")
    #=> "body{direction:ltr;}"

## Build Status

[![Build Status](https://travis-ci.org/mzsanford/R2rb.png)](https://travis-ci.org/mzsanford/R2rb)

## Reporting bugs

Report bugs in the github project at http://github.com/mzsanford/r2rb

## Change Log

 * v0.2.7 - Add an option to skip R2 processing on a CSS block (error report from [@mapmeld](https://github.com/mapmeld))
 * v0.2.6 - Handle multi-row selectors (fix from [@n0nick](https://github.com/n0nick))
 * v0.2.5 - Handle `background:` shorthand
 * v0.2.4 - Handle `url()` properties better
   * [BUG] - Handle `url()` without embedded semi-colons and with trailing parameters
 * v0.2.3 - Handle `url()` properties better
   * [BUG] - Handle `url()` with embedded semi-colons (like escaped SVG)
   * [CHANGE] - Remove Travis tests for Ruby 1.8 because Travis adds a `celluloid` dependency that does not work before Ruby 1.9.3
 * v0.2.2 – CSS3 `box-shadow` fix continues
   * [BUG] Correctly handle `box-shadow` declarations that define multiple shadows (fix from [@wazeHQ](https://github.com/wazeHQ))
   * [FEATURE] Make the `r2` command line tool convert CSS provided via `stdin` or a file (previously it was a no-op)
 * v0.2.1 – CSS3 `box-shadow` fix
   * [BUG] Correctly handle `box-shadow` declarations starting with `inset` (fix from [@wazeHQ](https://github.com/wazeHQ))
 * v0.2.0 – CSS3 additions
   * [FEATURE] Support `@media` queries by ignoring them (fix from [@haimlankry](https://github.com/haimlankry))
   * [FEATURE] Correctly flip `box-shadow` values (bug report from [@aviaron](https://github.com/aviaron))
 * v0.1.0 – [@fractious](https://github.com/fractious) updates
   * [CLEANUP] Added rspec dev dependency
   * [CLEANUP] Fixed typo in internal method name
   * [FEATURE] Added support for background-position
 * v0.0.3 - Feature release
   * [FEATURE] Added -moz and -webkit border support
   * [FEATURE] Added box-shadow (+moz and webkit) support
   * [DOC] Added change log
 * v0.0.2 - Documentation updated
 * v0.0.1 - Initial release

## Copyright and License

     Copyright 2011 Twitter, Inc.

     Licensed under the Apache License, Version 2.0 (the "License");
     you may not use this work except in compliance with the License.
     You may obtain a copy of the License in the LICENSE file, or at:

       http://www.apache.org/licenses/LICENSE-2.0

     Unless required by applicable law or agreed to in writing, software
     distributed under the License is distributed on an "AS IS" BASIS,
     WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
     See the License for the specific language governing permissions and
     limitations under the License.
