Package.describe({
  name: 'oorabona:famous-views-popup',
  summary: 'Use Famo.us for your popups!',
  version: '0.1.3',
  git: 'https://github.com/oorabona/famous-views-popup.git'
});

Package.on_use(function(api) {
  // Meteor version
  api.versionsFrom('METEOR@1.0');
  // FIXME: Should I remove coffeescript dependency here?
  api.use('coffeescript@1.0.1', 'client');

  // Core dependencies
  api.use('underscore', 'client');
  api.use('reactive-var', 'client');
  api.use('blaze', 'client');
  api.use('templating', 'client');
  api.use('tracker', 'client');
  api.use('random', 'client');

  api.use('mjn:famous@0.3.0_5', 'client', { weak: true });
  api.use('raix:famono@0.9.14', { weak: true });

  api.use('gadicohen:famous-views', 'client');
  api.imply('gadicohen:famous-views@0.1.18')

  // Files to be added to project
  api.add_files('popupmodal.html', 'client');
  api.add_files('popupmodal.coffee', 'client');
});
