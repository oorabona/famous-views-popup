famous-views-popup
==================

Meteor Famo.us Views Popup widget.
Exposes a __Popups__ object which allows you to use the following functions:

```coffeescript
Popups.setup opts
```

With `opts` as an object allowing:
* `translate`: Where the popup ends up. Default `[0, 0, 999]`.
* `size`: Size of the modal. Default: `[undefined, undefined]`.
* `template`: Blaze's template of the modal. Default: `"modal_backdrop"`.
* `opacity`: Opacity of the backdrop. Default 0.5.
* `backdropCloseOnClick`: Make the popup disapear when backdrop is clicked. Default: `true`.
* `lightbox`: You can set your own [`famous.views.Lighbox`](http://famo.us/docs/views/Lightbox).

To set up how popups will behave, i.e. transformations, animations, modal backdrop, etc.

```coffeescript
Popups.show opts
```

Use this function to show a modal popup. The only mandatory option here is "template" which is the template you want
to render in famous-views-popup

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
