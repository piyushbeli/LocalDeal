var appVendor = angular
    .module('LocalDeal_Vendor', [
        'ngRoute','templates', 'ui.router', 'ng-token-auth', 'ui.bootstrap'
    ]);

appVendor.config(function ($routeProvider, $stateProvider, $urlRouterProvider, $authProvider, Routes) {
    $stateProvider
        .state('verifyLogin', Routes.verifyLogin)
        .state('login', Routes.login)
        .state('app', Routes.root)
        .state('app.deals', Routes.deals)
        .state('app.dealDetail', Routes.dealDetail)
        .state('app.addresses', Routes.addresses)

    $urlRouterProvider.otherwise('verifyLogin');
    //$locationProvider.html5Mode(true);

    $authProvider.configure({
        apiUrl: 'vendor_auth'
    })
});