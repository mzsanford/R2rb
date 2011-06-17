== R2

Library for swapping CSS values for right-to-left display. A direct Ruby port of the Javascript/Node project at https://github.com/ded/R2.

== Installation ==

    $ gem install r2

== Usage ==

You can use the handy static method for flipping any CSS string via:

    > R2.r2("/* Comment */\nbody { direction: rtl; }")
    #=> "body{direction:ltr;}"

== Reporting bugs ==

Report bugs in the github project at http://github.com/mzsanford/r2rb

== Copyright and License ==

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