if Package.Template
  { Transform } = famous.core
  { Easing } = famous.transitions
  { Lightbox } = famous.views
  { Timer } = famous.utilities

  _popups = new ReactiveVar
  _setup = new ReactiveVar

  _popups.set []

  @Popups =
    # You can override the default popup animation here. It is an exact replica
    # of famous.views.Lightbox options parameter
    _defaultLightbox:
      inTransform: Transform.translate 0,500,0
      outTransform: Transform.translate 0,500,0
      inTransition:
        duration: 1000
        curve: Easing.outElastic
      outTransition:
        duration: 2000
        curve: Easing.inOutQuad

    # This can be called anytime and will firstly be called during popup init
    setup: (opts = {}) ->
      opts.translate = [0,0,999]
      opts.size = [undefined,undefined]
      opts.template ?= "modal_backdrop"
      opts.opacity ?= 0.5
      opts.backdropCloseOnClick ?= true
      opts.lightbox ?= @_defaultLightbox
      _setup.set opts
      return

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
          return
        else
          popup

      # Wait for out animation to complete if nowait is false
      Timer.setTimeout (->
        _popups.set shown
        cb && cb()
      ), duration
      return

    show: (opts = {}) ->
      opts.show = true
      @_add opts

    _add: (opts) ->
      unless opts.template
        console.error "You need to specify a template to render!", opts
        return

      # FIXME: It apparently confuses with #View ID and modifies its reference
      # Temp fix is to generate a random integer and expect it to not be already
      # a FamousView ID.
      opts.id ?= getRandomInt 1000, 2000

      # If we have translate option and a Z index, add enough so that it will
      # be quite so "in front" of everything else.
      translate = opts.translate ? [0,0,0]
      translate[2] += 1000
      opts.translate = translate

      p = _popups.get()
      p.push opts
      _popups.set p
      opts.id

  Template.modal_popup.helpers
    modalBackdrop: ->
      if _popups.get().length > 0
        unless _setup.get()
          Popups.setup()
        return _setup.get()
      return false
    popup: ->
      _popups.get()

    getSizeFromViewport: ->
      viewport = getViewport()
      [Math.ceil(viewport.width*0.90), Math.ceil(viewport.height*0.90)]

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
      child.surface.lightbox = new Lightbox lightbox
      fview.node.add child.surface.lightbox
      child.surface.lightbox.show child.surface

      return

  Template.modal_backdrop.events
    "click": (evt,tmpl) ->
      # from last inserted to first we hide and then remove modals
      setup = _setup.get()
      if setup.backdropCloseOnClick
        # No specific popup => remove 'em all
        Popups.hide()
      return

  Tracker.autorun ->
    return
