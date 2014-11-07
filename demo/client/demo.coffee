popup = null

Template.hello.events
  'click button': (evt, tmpl) ->
    # Show popup
    popup = new Popups modal: evt.currentTarget.id is "modal"
    popup.show
      template: "world"
    return
