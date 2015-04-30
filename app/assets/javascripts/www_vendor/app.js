var appVendor = angular
    .module('LocalDeal_Vendor', [
        'ngRoute','templates', 'ui.router', 'ng-token-auth', 'ui.bootstrap'
    ]);

appVendor.config(function ($routeProvider, $stateProvider, $urlRouterProvider, $authProvider, Routes, Constants) {
    $stateProvider
        .state('verifyLogin', Routes.verifyLogin)
        .state('login', Routes.login)
        .state('app', Routes.root)
        .state('app.deals', Routes.deals)
        .state('app.dealDetail', Routes.dealDetail)
        .state('app.addresses', Routes.addresses)
        .state('emailConfirmation', Routes.emailConfirmation)

    $urlRouterProvider.otherwise('app/deals');
    //$locationProvider.html5Mode(true);

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
    })
});