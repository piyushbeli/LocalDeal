var appVendor = angular
    .module('LocalDeal_Vendor', [
        'uiGmapgoogle-maps', 'app.common'
    ]);

appVendor.config(['$routeProvider', '$locationProvider', '$stateProvider', '$urlRouterProvider', '$authProvider',
    'uiGmapGoogleMapApiProvider', 'Routes', 'Constants', function ($routeProvider, $locationProvider, $stateProvider, $urlRouterProvider, $authProvider,
                           uiGmapGoogleMapApiProvider, Routes, Constants) {
    $stateProvider
        .state('login', Routes.login)
        .state('app', Routes.root)
        .state('app.deals', Routes.deals)
        .state('app.dealDetail', Routes.dealDetail)
        .state('app.newDeal', Routes.newDeal)
        .state('app.dealDetail.offerDetail', Routes.offerDetail)
        .state('app.dealDetail.newOffer', Routes.newOffer)
        .state('app.addresses', Routes.addresses)
        .state('app.outlets', Routes.outlets)
        .state('app.outletDetail', Routes.outletDetail)
        .state('app.newOutlet', Routes.newOutlet)
        .state('emailConfirmation', Routes.emailConfirmation)
        .state('app.accountDetail', Routes.accountDetail)

    $urlRouterProvider.otherwise('vendor/app/deals');
    $locationProvider.html5Mode(true);

    $authProvider.configure({
        apiUrl: '',
        tokenValidationPath:     '/auth_vendor/validate_token',
        signOutUrl:              '/auth_vendor/sign_out',
        emailRegistrationPath:   '/auth_vendor',
        accountUpdatePath:       '/auth_vendor',
        accountDeletePath:       '/auth_vendor',
        confirmationSuccessUrl:  Constants.emailConfirmationUrl,
        passwordResetPath:       '/auth_vendor/password',
        passwordUpdatePath:      '/auth_vendor/password',
        passwordResetSuccessUrl: window.location.href,
        emailSignInPath:         '/auth_vendor/sign_in'
    });

    uiGmapGoogleMapApiProvider.configure({
        //key: 'your api key',
        v: '3.19.18',
        libraries: 'weather,geometry,visualization'
    });
}]);