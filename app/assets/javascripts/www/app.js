var appUser = angular
    .module('LocalDeal_User', [
        'app.common', 'infinite-scroll', 'ngScrollTo'
    ]);

appUser.config(function ($routeProvider, $stateProvider, $urlRouterProvider, $authProvider, $locationProvider, uiGmapGoogleMapApiProvider, Routes) {
    $stateProvider
        .state('app', Routes.root)
        .state('app.profile', Routes.profile)
        .state('app.outlets', Routes.outlets)
        .state('app.outletDetail', Routes.outletDetail)
        .state('app.outletDetail.deals', Routes.deals)
        .state('app.outletDetail.dealDetail', Routes.dealDetail)

    $urlRouterProvider.otherwise('app/outlets');
    $locationProvider.html5Mode(true);

    $authProvider.configure({
        apiUrl: '',
        authProviderPaths: {
            github:   '/auth/github',
            facebook: '/auth/facebook',
            google:   '/auth/google_oauth2'
        }
    });

    uiGmapGoogleMapApiProvider.configure({
        //key: 'your api key',
        v: '3.17',
        libraries: 'weather,geometry,visualization'
    });
});