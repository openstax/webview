(function () {
  'use strict';

  var authoringModules = [
    'select2',
    'bootstrapPopover',
    'cs!pages/workspace/workspace',
    'cs!pages/role-acceptance/role-acceptance',
    'cs!modules/media/editbar/editbar',
    'cs!configs/aloha'
  ];

  // Load the config
  require(authoringModules, function (select2, bootstrapPopover, workspace, roleAcceptance, editbar, aloha) {
    return [select2, bootstrapPopover, workspace, roleAcceptance, editbar, aloha];
  });

})();
