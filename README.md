famous-views-popup
==================

Meteor Famo.us Views Popup widget.
Exposes a __Popups__ object which allows you to use the following functions:

```coffeescript
Popups.setup opts
```

To set up how popups will behave, i.e. transformations, animations, modal backdrop, etc.

```coffeescript
Popups.show opts
```

Use this function to show a modal popup. The only mandatory option here is "template" which is the template you want
to render in famous-views-popup
==================

Meteor Famo.us Views Popup widget.
Exposes a __Popups__ object which allows you to use the following functions:

```coffeescript
Popups.setup opts
```

To set up how popups will behave, i.e. transformations, animations, modal backdrop, etc.

```coffeescript
Popups.show opts
```

Use this function to show a modal popup. The only mandatory option here is "template" which is the template you want
to render in the popup.

```coffeescript
Popups.hide query?, callback
```

Hide a specific popup. Query works like a database query, you can filter to any key:value pairs.
Callback is called once the animation is over, from a setTimeout function.

I have exported this piece of code from a bigger project.
Code should work but I am having issues with the new meteor packaging system and coffeescript.

Help would be very much appreciated !the popup.

```coffeescript
Popups.hide query?, callback
```

Hide a specific popup. Query works like a database query, you can filter to any key:value pairs.
Callback is called once the animation is over, from a setTimeout function.

I have exported this piece of code from a bigger project.
Code should work but I am having issues with the new meteor packaging system and coffeescript.

Help would be very much appreciated !
