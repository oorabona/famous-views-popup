_popups = new ReactiveVar []
_setup = new ReactiveVar

getRandomInt = (min, max) ->
  Math.floor(Math.random() * (max - min)) + min

@Popups =
  # Default size with the same name as Bootstrap. But not the same meaning!
  sizes:
    'modal-sm': "[300, true]"
    'modal': "[600, true]"
    'modal-lg': "[900, true]"

  # We define how our backdrop will behave
  setOptions: (opts = {}) ->
    opts.opacity ?= 0.5
    # If true (default), handles automagically clicks to backdrop and bind to
    # a "close all" event.
    opts.backdropCloseOnClick ?= true
    opts.lightbox ?= {}
    _.defaults opts.lightbox, @_defaultLightbox

    _setup.set opts

  # Hide a modal (i.e. remove it from the list)
  hide: (query, cb) ->
    if typeof query == "function"
      [cb, query] = [query, {}]

    popups = _popups.get()
    setup = _setup.get()
    {duration} = setup.lightbox.outTransition
    shown = _.compact popups.map (popup) ->
      shouldRemove = true
      for k,v of query
        if popup[k] != v then shouldRemove = false

      if shouldRemove
        fview = FView.byId popup.id
        return unless fview
        child = fview.children[0]
        duration = popup.lightbox?.outTransition.duration ? duration
        child?.surface.lightbox.hide()
      else
        popup

    # Wait for out animation to complete and call back if needed
    famous.utilities.Timer.setTimeout ->
      _popups.set shown
      cb && cb()
    , duration

  show: (opts = {}, cb) ->
    if typeof opts == "function"
      [cb, opts] = [opts, {}]
    id = @_add opts
    cb && cb id
    id

  _add: (opts) ->
    unless opts.template
      console.error 'You need to specify a template to render!', opts
      return

    # If setup not defined, set default options
    unless _setup.get()
      @setOptions()

    # FIXME: It apparently confuses with #View ID and modifies its reference
    # Temp fix is to generate a random integer and expect it to not be already
    # a FamousView ID.
    opts.id ?= getRandomInt 1000, 2000

    # If we have translate option and a Z index, add enough to be "in front"
    p = _popups.get()
    translate = opts.translate ? [0,0,0]
    translate[2] += 1000 + p.length
    opts.translate = translate

    # Center by default
    opts.origin ?= [.5,.5]
    opts.align ?= [.5,.5]

    # Check if we were given a valid size
    if opts.size
      sizeStr = eval "'#{opts.size}'"
      if typeof @sizes[sizeStr] == "undefined"
        size = eval opts.size
        # If array we keep it as is. Otherwise it may be a size 'shortcut'
        unless size instanceof Array
          throw "Size not defined in Popups.sizes: #{opts.size}"
      else
        opts.size = @sizes[opts.size]

    p.push opts
    _popups.set p
    opts.id

# You can override the default popup animation here. This is what will be given
# to famo.us lightbox when template is rendered.
FView.ready ->
  Popups._defaultLightbox =
    inTransform: famous.core.Transform.translate 0,-500,0
    outTransform: famous.core.Transform.translate 0,500,0
    inTransition:
      duration: 500
      curve: famous.transitions.Easing.outElastic
    outTransition:
      duration: 1000
      curve: famous.transitions.Easing.inOutQuad

Template.modal_popup.helpers
  backdrop: ->
    if _popups.get().length > 0 then _setup.get() else false
  popup: ->
    _popups.get()

Template._modal_popup.rendered = ->
  {id, lightbox} = @data

  # Has to be done after child has rendered
  Meteor.defer ->
    fview = FView.byId id
    child = fview.children[0]

    # We can override setup lightbox on a per popup basis :)
    lightbox ?= {}
    setup = _setup.get()
    _.defaults lightbox, setup.lightbox

    # http://stackoverflow.com/questions/24806437/built-in-popup-modal
    child.surface.lightbox = new famous.views.Lightbox lightbox
    fview.node.add child.surface.lightbox
    child.surface.lightbox.show child.surface

Template.fvm_backdrop.events
  'click': (evt,tmpl) ->
    # from last inserted to first we hide and then remove modals
    setup = _setup.get()
    if setup.backdropCloseOnClick
      # No specific popup => remove 'em all
      popups = _popups.get()
      {duration} = setup.lightbox?.outTransition
      for popup in popups
        do (popup) ->
          fview = FView.byId popup.id
          return unless fview
          child = fview.children[0]
          duration = popup.lightbox?.outTransition.duration ? duration
          child?.surface.lightbox.hide()

      # Wait for out animation to complete
      famous.utilities.Timer.setTimeout ->
        _popups.set []
      , duration
