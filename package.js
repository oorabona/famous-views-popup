Package.describe({
  name: 'oo:famous-views-popup',
  summary: 'Use Famo.us for your popups!',
<<<<<<< HEAD
  version: '1.0.0',
=======
  version: '0.1.0',
>>>>>>> b3e5f335cc3a65ab932283dc7738ad05c056d393
  git: 'https://github.com/oorabona/famous-views-popup.git'
});
Package.onUse({
  // are as of meteor@0.9.0.
  api.versionsFrom('METEOR@0.9.0');
  api.use('underscore', ['client']);
  api.use('coffeescript', ['client']);
  api.use('gadicohen:famous-views', 'client');
  api.addFiles(['popupmodal.coffee', 'popupmodal.html'], 'client');
});
