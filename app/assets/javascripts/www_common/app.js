var appCommon = angular.module("app.common", ['angular-cache', 'ngRoute', 'templates', 'ui.router', 'ng-token-auth', 'ui.bootstrap', 'ngAutocomplete', 'ngCookies',
    'checklist-model', 'ui.bootstrap.datetimepicker', 'uiGmapgoogle-maps', 'geocoder', 'chieffancypants.loadingBar'])
    .config(['cfpLoadingBarProvider', function (cfpLoadingBarProvider) {
        cfpLoadingBarProvider.includeSpinner = false;
    }])