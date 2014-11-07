famous-views-popup
==================

A [Meteor Famo.us Views](https://github.com/gadicc/meteor-famous-views) Popup widget. Tested with Meteor 1.0 but should work with
previous versions.

# API
Exposes a __Popups__ object which you can instantiate with:

```javascript
my_popup = new Popups(opts);
```

Opts parameter is as follows:
* all #Surface related options: translate, size, etc. of the modal backdrop
* lightbox: [Famo.us Lightbox](http://famo.us/docs/views/Lightbox)

If no lightbox is specified, the default one is used.
Example, thanks to this [SO](http://stackoverflow.com/questions/24806437/built-in-popup-modal) post:

```javascript
my_popup = new Popups({
  lightbox: {
    inTransform: famous.core.Transform.translate(0,500,0),
    outTransform: famous.core.Transform.translate(0,500,0),
    inTransition: {
      duration: 1000,
      curve: famous.transitions.Easing.outElastic
    },
    outTransition: {
      duration: 2000,
      curve: famous.transitions.Easing.inOutQuad
    }
  }
});
```

You also need to add this somewhere:

```mustache
<template name="famousInit">
  {{> modal_popup}}
</template>
```

And this is all set up.

## Show popup

```javascript
my_popup.show(opts);
```

Use this function to show a modal popup. The only mandatory option here is "template" which is the popup template you want to render.

Options:
* *template*: the template name to render
* *id*: if you want to override it (see [TODO](#todo) list below)
* *translate*: if you want to use this feature. Note, Z axis is automatically adjusted with a +1000 so that it is always in front.
* *lightbox*: overrides lightbox options you could have set up during init.

Example:

```javascript
my_popup.show({template: "popup"});
```

And your templates should be defined like this:

```mustache
<template name="popup">
  {{> Surface template="_popup"}}
</template>

<template name="_popup">
  <div class="my_popup">
    <h1>Popup!</h1>
  </div>
</template>
```

Indeed, you need to specify which Famo.us surface you want to use. In general you will use a {{> Surface ...}} but it may be another registered Famo.us helper.

## Hide
Hide a specific popup.

```javascript
// Function signature
my_popup.hide(query, callback);
// If no query (i.e. remove all popups)
my_popup.hide(callback);
// Or if you do not need a callback
my_popup.hide();
```

*query* works like a database query, you can filter to any key:value pairs.
E.g:

```javascript
my_popup.hide({id: "popup"}, function() { Session.set("my-popup-data", null); });
```

Callback is called once the animation is over, from a setTimeout function.

# TODO
* Better sizing capabilities (at the moment it always takes 90% of viewport width and height).
* Fixing *id* issue when used in Popups.show()
* Issues and PR welcome :)

# License
MIT
