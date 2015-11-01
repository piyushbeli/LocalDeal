var appUser = angular
    .module('LocalDeal_User', [
        'app.common', 'infinite-scroll', 'ngScrollTo'
    ]);

appUser.config(['$routeProvider', '$stateProvider', '$urlRouterProvider', '$authProvider', '$locationProvider', 'uiGmapGoogleMapApiProvider', 'Routes',
    function ($routeProvider, $stateProvider, $urlRouterProvider, $authProvider, $locationProvider, uiGmapGoogleMapApiProvider, Routes) {
    $stateProvider
        .state('app', Routes.root)
        .state('app.profile', Routes.profile)
        .state('app.outlets', Routes.outlets)
        .state('app.outletDetail', Routes.outletDetail)
        .state('app.outletDetail.deals', Routes.deals)
        .state('app.outletDetail.dealDetail', Routes.dealDetail)
        .state('app.orders', Routes.orders)
        .state('app.orderDetail', Routes.orderDetail)
        .state('app.favoriteOutlets', Routes.favoriteOutlets)

    $urlRouterProvider.otherwise('app/outlets');
    $locationProvider.html5Mode(true);

    $authProvider.configure({
        apiUrl: '',
        authProviderPaths: {
            github:   '/auth/github',
            facebook: '/auth/facebook',
            google:   '/auth/google_oauth2'
        },
        omniauthWindowType: 'newWindow'
    });

    uiGmapGoogleMapApiProvider.configure({
        //key: 'your api key',
        v: '3.17',
        libraries: 'weather,geometry,visualization'
    });
}]);