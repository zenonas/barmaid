barmaid
=======

A lightweight tool to live in your menu bar that allows you to start and stop homebrew installed services such as redis, postgres, mongodb etc.

Written in Swift!

## Releases

Barmaid is currently in development, a beta version will be available soon.

## How it works

Barmaid looks at all the homebrew plists installed in /usr/local/opt to discover any services available. Then provides a thin wrapper around launchctl to manage these services.

## LICENSE

Barmaid is licensed under the MIT License. See the LISENSE file for more information
