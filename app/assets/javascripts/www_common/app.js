var appCommon = angular.module("app.common", ['angular-cache', 'ngRoute', 'templates', 'ui.router', 'ng-token-auth',
    'ui.bootstrap', 'ngAutocomplete', 'checklist-model', 'ui.bootstrap.datetimepicker', 'uiGmapgoogle-maps', 'geocoder',
    'chieffancypants.loadingBar', 'isteven-multi-select', 'valdr', 'ngFileUpload'])
    .config(['cfpLoadingBarProvider','valdrProvider', 'ValdrConfig', function (cfpLoadingBarProvider, valdrProvider, ValdrConfig) {
        cfpLoadingBarProvider.includeSpinner = false;
        valdrProvider.addValidator('customValidator');
        valdrProvider.addConstraints(ValdrConfig)
    }]);

//Add custom validator for Number
appCommon.factory('customValidator', function () {
    return {
        name: 'number', // this is the validator name that can be referenced from the constraints JSON
        validate: function (value, arguments) {
            // value: the value to validate
            // arguments: the validator arguments
            return !isNaN(value);
        }
    };
});