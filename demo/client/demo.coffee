popup = null

Template.hello.events
  'click button': (evt, tmpl) ->
    # Show popup
    modal = true
    if evt.currentTarget.id is "nomodal" then modal = false

    popup = new Popups modal: modal
    popup.show
      template: evt.currentTarget.id

    return

Template._bootstrap.rendered = ->
  # Modal manual opening
  @$('.modal').addClass('in').css
    display: 'block'
    overflow: 'hidden'
  return
