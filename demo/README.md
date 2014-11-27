{{#template name="readme"}}
# Meteor Famous Views Modal popups demo!

Hello World! This is the demo app of [Famous Views Popup](https://github.com/oorabona/famous-views-popup)
project.

You can add it to your Meteor project with a simple:
```bash
meteor add oorabona:famous-views-popup
```

You can experiment with the top nav items. If you find an issue, feel free to
fill an issue on [Github](https://github.com/oorabona/famous-views-popup/issues) !

# How does it work ?

Actually this package depends heavily on [Meteor Famous Views](https://github.com/gadicc/meteor-famous-views)
to provide a [Famo.us Lightbox](https://famo.us/docs/views/Lightbox) to show the popup.

## Lightbox

Default lightbox was taken from this answer on [SO](http://stackoverflow.com/questions/24806437/built-in-popup-modal)
```javascript
{
  inTransform: famous.core.Transform.translate(0,-500,0),
  outTransform: famous.core.Transform.translate(0,500,0),
  inTransition: {
    duration: 500,
    curve: famous.transitions.Easing.outElastic
  },
  outTransition: {
    duration: 1000,
    curve: famous.transitions.Easing.inOutQuad
  }
}
```

## Templates

Your templates should be defined like this:

```
<template name="popup">
  { {> Surface template="_popup"}}
</template>

<template name="_popup">
  <div class="my_popup">
    <h1>Popup!</h1>
  </div>
</template>
```

Indeed, you need to specify which Famo.us surface you want to use. In general you will use a '{ {> Surface ...}}' but it may be another registered FView helper.

Also better to handle events in Plain Old HTML on another template and split HTML and Famo.us Surface events explicitly.

Last but certainly not the least, you **MUST** call 'modal_popup' template somewhere at the very beginning, like:

```
<template name="famousInit">
  { {> modal_popup}}
</template>
```

Voilà! You are all set!

Now, you can call Popups at any time using this API.

# API

> Yoda says: ' Use the Code, Luke '

## setOptions

Sets common options. Backdrop opacity and how Popups should take care of click on backdrop. If true, clicking on backdrop will force close __all__ opened popups.
```javascript
Popups.setOptions({
  opacity: 0.5
  backdropCloseOnClick: true
  lightbox: <lightbox>
});
```
> Lightbox defined here will be default lightbox for upcoming popups (but popups can override, see below).

## show

Shows popup, with possibility to override _lightbox_:
```javascript
Popups.show({
  template: "popup",
  size: "[600, true]"
  lightbox: <lightbox>
}, callback);
```

__callback__ is called __AFTER__ animation completed.

>Options:

>* *template*: the template name to render
>* *id*: if you want to override it (USE WITH CAUTION!)
>* *translate*: if you want to use this feature. Note, Z axis is automatically adjusted with a +1000 so that it is always in front.
>* *lightbox*: overrides lightbox options you could have set up with setOptions(...).
>* *size*: Famo.us object size

You can of course add _origin_, _align_ or any other parameter. All relevant parameters
will be used by FView. Note that you may also pass your own data along the way.

An alternate syntax is available as a 'shortcut' for sizes. Example:

```javascript
Popups.show({
  template: "popup",
  size: 'modal-sm'
}, callback);
```

Then, if configuration matches, size will be adjusted automagically. Configuration is
in Popups.sizes. A simple object with key values pairs. Defaults are:

```javascript
Popups.sizes = {
  'modal-sm': "[300, true]"
  'modal': "[600, true]"
  'modal-lg': "[900, true]"
};
```

The 'true' height is needed so that Famo.us does not need to know real height.

__These class names are not to be confused with Bootstrap modal classes !__

> Note:
> Bootstrap modals work nicely with the package but with additional CSS. A better solution is yet to be found.

## hide

Hide a template, based on a query. E.g:

```javascript
// Function signature
my_popup.hide(query, callback);
// If no query (i.e. remove all popups)
my_popup.hide(callback);
// Or if you do not need a callback
my_popup.hide();
```

>*query* works like a database query, you can filter with any key:value pair.
>*callback* is called once the animation is over, from a setTimeout function.

Where first parameter is a query. Most often 'id' will be used. But actually
you could filter according to size as well!

Example:

```javascript
Template.foo.events({
  'click #close': function(evt, tmpl) {
    Popups.hide({id: this.id}, function() {
      Session.set("my-popup-data", null);
    });
  }
});
```

{{/template}}
