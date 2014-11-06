Package.describe({
  name: 'oo:famous-views-popup',
  summary: 'Use Famo.us for your popups!',
  version: '1.0.0',
  git: 'https://github.com/oorabona/famous-views-popup.git'
});

Package.onUse({
  // are as of meteor@0.9.0.
  api.versionsFrom('METEOR@0.9.0');
  // FIXME: Should I remove coffeescript dependency here?
  api.use(['underscore','coffeescript'], 'client');
  api.use('gadicohen:famous-views@0.1.20', 'client');

  // Files to be added to project
  api.addFiles(['popupmodal.coffee', 'popupmodal.html'], 'client');
});
