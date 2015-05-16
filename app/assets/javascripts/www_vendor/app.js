var appVendor = angular
    .module('LocalDeal_Vendor', [
        'app.common', 'ngRoute','templates', 'ui.router', 'ng-token-auth', 'ui.bootstrap', 'ngAutocomplete',
        'checklist-model'
    ]);

appVendor.config(function ($routeProvider, $stateProvider, $urlRouterProvider, $authProvider, Routes, Constants) {
    $stateProvider
        .state('login', Routes.login)
        .state('app', Routes.root)
        .state('app.deals', Routes.deals)
        .state('app.dealDetail', Routes.dealDetail)
        .state('app.newDeal', Routes.newDeal)
        .state('app.dealDetail.offerDetail', Routes.offerDetail)
        .state('app.dealDetail.newOffer', Routes.newOffer)
        .state('app.addresses', Routes.addresses)
        .state('emailConfirmation', Routes.emailConfirmation)
        .state('app.accountDetail', Routes.accountDetail)

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