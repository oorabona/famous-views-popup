popup = null

Template.hello.events
  'click button': (evt, tmpl) ->
    # Show popup
    console.log "clicked!", evt.currentTarget.id is "modal"
    popup = new Popups modal: evt.currentTarget.id is "modal"
    popup.show
      template: "world"
    return
