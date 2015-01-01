famous-views-popup
==================

A [Meteor Famo.us Views](https://github.com/gadicc/meteor-famous-views) Popup widget.
Tested with Meteor 1.0 but should work with previous versions.

You can see a live demo [here](http://famous-views-popup.meteor.com)

# API

You can read it [here](https://github.com/oorabona/famous-views-popup/demo).

# Support

Tested and developed with Chrome/Chromium. Works somewhat on Firefox, but seems
to have at least opacity problems.

# Changelog

What's new in v2.0.0 ?
* Upgraded to work with latest (0.1.30 to date) version of Meteor Famous Views.
* Removed ```translateZ``` in favor of CSS ```z-index``` which seems to cause less trouble.
* Potential memory leak, induced by the use of ```#each``` instead of ```#famousEach``` and Famo.us ```#Surface``` cleaning when templates are destroyed, should now be limited if not gone.
* ```#Surface``` has now replaced ```#View```. It simplifies a lot the most common case where a popup is just a simple ```#Surface``` and I have found no real use case where a ```#View``` would be required. So until it bothers someone (feel free to open a new issue) it is now way simpler to handle popups!
* ```Popups.hide(...)``` new signature (see [API](#API))
* Fixed ID mangling when ```Random.id()``` would return a string starting with one (or more digits). Now forced to prefix with "popup_" so that it is always a string, no matter the randomness :wink:

What's new in v1.1.2 ?
* I reworked the whole demo, added images, new examples and moved API documentation over there.
* Added better sizing (thanks @PEM-- for pointing this out)
* Full support of Bootstrap modals (until an new issue is opened :))
* Code cleanup of course

# TODO

*   Better sizing capabilities
> Sizing can now be done with "[x, y]" like usual or with a shortcut key returning size based on a key string: "modal-lg".

~~~ Fixing *id* issue when used in Popups.show()~~~

* Make it work on other browsers than Chrome. Actually works on both
mobile and desktop Chrome/Chromium!

* Issues and PR welcome :)

# License

MIT
