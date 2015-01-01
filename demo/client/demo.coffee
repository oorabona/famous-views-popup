# Demo code

UI.registerHelper 'checkedIf', (val) ->
  if val then 'checked' else ''

Session.setDefault 'randomTransitions', false
Session.setDefault 'showbd', true
Session.setDefault 'cocbd', true
Session.setDefault 'opacity', 0.5
Session.setDefault 'inDuration', 1000
Session.setDefault 'outDuration', 2000
Session.setDefault 'inTransform', [0,-500,0]
Session.setDefault 'outTransform', [0,500,0]

# Neat trick to add a "fake" size so that code below is simpler
Popups.sizes.simple = "[600, true]"

allTransitions = ["inQuad", "outQuad", "inOutQuad", "inCubic", "outCubic",
  "inOutCubic", "inQuart", "outQuart", "inOutQuart", "inQuint", "outQuint",
  "inOutQuint", "inSine", "outSine", "inOutSine", "inExpo", "outExpo", "inOutExpo",
  "inCirc", "outCirc", "inOutCirc", "inElastic", "outElastic", "inOutElastic",
  "inBack", "outBack", "inOutBack", "inBounce", "outBounce", "inOutBounce"]
Session.setDefault 'currentTransitions', [allTransitions[0], allTransitions[0]]

getRandomInt = (min, max) ->
  Math.floor(Math.random() * (max - min)) + min

Template.header.events
  'click a': (evt, tmpl) ->
    # If no random transition, use first element of ecah in/out array
    if Session.get 'randomTransitions'
      randomInId = getRandomInt 0, allTransitions.length - 1
      randomOutId = getRandomInt 0, allTransitions.length - 1
      Session.set 'currentTransitions', [allTransitions[randomInId], allTransitions[randomOutId]]

    # Make sure we only have integers here
    it = Session.get('inTransform').map (el) ->
      parseInt el

    ot = Session.get('outTransform').map (el) ->
      parseInt el

    # Will use them to determine in and out transition curves
    ct = Session.get 'currentTransitions'

    # Set/update options
    Popups.setOptions
      modal: Session.get 'showbd'
      backdropCloseOnClick: Session.get 'cocbd'
      opacity: Session.get 'opacity'
      lightbox:
        inTransform: famous.core.Transform.translate.apply @, it
        outTransform: famous.core.Transform.translate.apply @, ot
        inTransition:
          duration: Session.get 'inDuration'
          curve: famous.transitions.Easing[ct[0]]
        outTransition:
          duration: Session.get 'outDuration'
          curve: famous.transitions.Easing[ct[1]]

    # Show popup
    Popups.show
      template: "bootstrap"
      size: evt.currentTarget.id
      modal_class: evt.currentTarget.id

    return

Template.bootstrap.helpers
  currentInTransition: -> Session.get('currentTransitions')[0]
  currentOutTransition: -> Session.get('currentTransitions')[1]

Template.bootstrap.rendered = ->
  @$('.modal').addClass('in').css
    display: 'block'
    overflow: 'hidden'
  return

Template.bootstrap.events
  'click #save': (evt, tmpl) ->
    Popups.show
      template: "saved"
      size: "[600, true]"

    return

  'click #close': (evt, tmpl) ->
    Popups.show
      template: "closed"
      size: "[600, true]"

    return

  'click .close': (evt, tmpl) ->
    Popups.hide @id
    return

Template.saved.rendered = ->
  # Modal manual opening
  @$('.modal').addClass('in').css
    display: 'block'
    overflow: 'hidden'
  return

Template.saved.events
  'click #ok': (evt, tmpl) ->
    Popups.hide @id
    return

Template.closed.events
  'click #ok': (evt, tmpl) ->
    Popups.hide @id
    return

Template._main.helpers
  showbd: -> Session.get 'showbd'
  cocbd: -> Session.get 'cocbd'
  opacity: -> Session.get 'opacity'
  rt: -> Session.get 'randomTransitions'
  inDuration: -> Session.get 'inDuration'
  outDuration: -> Session.get 'outDuration'
  inX: -> Session.get('inTransform')[0]
  inY: -> Session.get('inTransform')[1]
  inZ: -> Session.get('inTransform')[2]
  outX: -> Session.get('outTransform')[0]
  outY: -> Session.get('outTransform')[1]
  outZ: -> Session.get('outTransform')[2]
  curves: -> allTransitions

Template._main.events
  'input [name=opacity]': (evt, tmpl) ->
    Session.set 'opacity', $(evt.target).val()
    return

  'change #inCurve': (evt, tmpl) ->
    ct = Session.get 'currentTransitions'
    ct[0] = $(evt.target).val()
    Session.set 'currentTransitions', ct
    return

  'change #outCurve': (evt, tmpl) ->
    ct = Session.get 'currentTransitions'
    ct[1] = $(evt.target).val()
    Session.set 'currentTransitions', ct
    return

  'input [name=inDuration]': (evt, tmpl) ->
    Session.set 'inDuration', $(evt.target).val()
    return

  'input [name=outDuration]': (evt, tmpl) ->
    Session.set 'outDuration', $(evt.target).val()
    return

  'input [name=inX]': (evt, tmpl) ->
    it = Session.get 'inTransform'
    it[0] = $(evt.target).val()
    Session.set 'inTransform', it
    return

  'input [name=inY]': (evt, tmpl) ->
    it = Session.get 'inTransform'
    it[1] = $(evt.target).val()
    Session.set 'inTransform', it
    return

  'input [name=inZ]': (evt, tmpl) ->
    it = Session.get 'inTransform'
    it[2] = $(evt.target).val()
    Session.set 'inTransform', it
    return

  'input [name=outX]': (evt, tmpl) ->
    ot = Session.get 'outTransform'
    ot[0] = $(evt.target).val()
    Session.set 'outTransform', ot
    return

  'input [name=outY]': (evt, tmpl) ->
    ot = Session.get 'outTransform'
    ot[1] = $(evt.target).val()
    Session.set 'outTransform', ot
    return

  'input [name=outZ]': (evt, tmpl) ->
    ot = Session.get 'outTransform'
    ot[2] = $(evt.target).val()
    Session.set 'outTransform', ot
    return

  'change [name=rt]': (evt, tmpl) ->
    Session.set 'randomTransitions', $(evt.target).is ':checked'
    return

  'change [name=showbd]': (evt, tmpl) ->
    Session.set 'showbd', $(evt.target).is ':checked'
    return

  'change [name=cocbd]': (evt, tmpl) ->
    Session.set 'cocbd', $(evt.target).is ':checked'
    return

# FIXME: Must be a cleaner way to do that..
visible = false

Template._notice.events
  'click': (evt, tmpl) ->
    visible = false
    Popups.hide id: @id
    return

Tracker.autorun ->
  if !visible and Session.get('cocbd') and not Session.get 'showbd'
    visible = true
    Popups.show
      template: 'notice'
      size: "[600, true]"

# A bit of Yoda's Magic !
###
Meteor.setTimeout ->
  # Adapted from http://jsfiddle.net/ritcoder/beh9z/1/
  id = Popups.show
    template: "yoda"
    size: "[280,280]"
    lightbox:
      inTransform: famous.core.Transform.rotateY(Math.PI / 2)
      inOpacity: 1
      inOrigin: [0, 0]
      inTransition:
        duration: 250
        curve: 'linear'
      showOrigin: [0, 0]
      outOpacity: 1
      outOrigin: [0, 0]
      outTransform: famous.core.Transform.rotateZ(Math.PI / 2)
      outTransition:
        duration: 250
        curve: 'linear'
      overlap: true

  Meteor.setTimeout ->
    Popups.hide id: id
    return
  , getRandomInt 1000, 5000
  return
, getRandomInt 10000, 20000
###
