var appCommon = angular.module("app.common", ['angular-cache', 'ngRoute', 'templates', 'ui.router', 'ng-token-auth',
    'ui.bootstrap', 'ngAutocomplete', 'checklist-model', 'ui.bootstrap.datetimepicker', 'uiGmapgoogle-maps', 'geocoder',
    'chieffancypants.loadingBar', 'isteven-multi-select', 'valdr'])
    .config(['cfpLoadingBarProvider','valdrProvider', 'ValdrConfig', function (cfpLoadingBarProvider, valdrProvider, ValdrConfig) {
        cfpLoadingBarProvider.includeSpinner = false;
        valdrProvider.addConstraints(ValdrConfig)
    }])