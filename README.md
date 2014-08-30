barmaid
=======

A lightweight tool to live in your menu bar that allows you to start and stop homebrew installed services such as redis, postgres, mongodb etc.

Written in Swift!

## Releases

Barmaid v0.1beta is out!

## How it works

Barmaid looks at all the homebrew plists installed in /usr/local/opt to discover any services available. Then provides a thin wrapper around launchctl to manage these services.
![Barmaid Screenshot](http://i.imgur.com/loPdjhp.png)

## Requirements

* OS X 10.9 Mavericks or 10.10 Yosemite Beta
* Homebrew and at least one service that uses launchd installed

## LICENSE

Barmaid is licensed under the MIT License. See the LICENSE file for more information
