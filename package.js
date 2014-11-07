Package.describe({
  name: 'oorabona:famous-views-popup',
  summary: 'Use Famo.us for your popups!',
  version: '1.0.2',
  git: 'https://github.com/oorabona/famous-views-popup.git'
});

Package.onUse(function(api) {
  // Meteor version
  api.versionsFrom('METEOR@1.0');
  api.use('coffeescript@1.0.1', 'client');

  // Core dependencies
  api.use('underscore@1.0.1', 'client');
  api.use('reactive-var', 'client');
  api.use('templating', 'client');
  api.use('random', 'client');

  api.use('mjn:famous@0.3.0_5', 'client', { weak: true });
  api.use('raix:famono@0.9.14', { weak: true });

  api.use('gadicohen:famous-views@0.1.20', 'client');

  // Files to be added to project
  api.addFiles('popupmodal.html', 'client');
  api.addFiles('popupmodal.coffee', 'client');
  api.addFiles('popupmodal.css', 'client');
  //api.export('Popups');
});
