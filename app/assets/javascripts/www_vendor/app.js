var app = angular
    .module('LocalDeal_Vendor', [
        'ngRoute','templates', 'ui.router', 'ng-token-auth', 'ui.bootstrap'
    ]);

app.config(function ($routeProvider, $stateProvider, $urlRouterProvider, $authProvider) {
    $stateProvider
        .state('vendor', {
            url: '/vendor',
            abstract: true,
            views: {
                'navContent': {
                    templateUrl: 'nav/nav.html',
                    controller: 'NavController'
                }
            }
        })
        .state('vendor.posts', {
            url: '/posts',
            views: {
                'mainContent': {
                    templateUrl: 'post/post.html',
                    controller: 'PostController'
                }
            }
        })
        .state('vendor.postDetail', {
            url: '/posts/:id',
            views: {
                'mainContent': {
                    templateUrl: 'post/postDetail.html',
                    controller: 'PostDetailController'
                }
            },
            resolve: {
                PostService: 'PostService',
                post: function (PostService, $stateParams, $state) {
                    return PostService.fetchPost($stateParams['id']);
                }
            }
        })
    $urlRouterProvider.otherwise('vendor/posts');
    //$locationProvider.html5Mode(true);

    $authProvider.configure({
        apiUrl: '',
        authProviderPaths: {
            github:   '/auth/github',
            facebook: '/auth/facebook',
            google:   '/auth/google_oauth2'
        }
    })
});