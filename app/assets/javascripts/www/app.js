var app = angular
    .module('LocalDeal_User', [
        'ngRoute','templates', 'ui.router', 'ng-token-auth', 'ui.bootstrap'
    ]);

app.config(function ($routeProvider, $stateProvider, $urlRouterProvider, $authProvider, $locationProvider) {
    $stateProvider
        .state('user', {
            url: '/user',
            views: {
                'navContent': {
                    templateUrl: 'nav/nav.html',
                    controller: 'NavController'
                }
                /*'mainContent': {
                    templateUrl: 'home/home.html'
                }*/
            }
        })
        .state('user.posts', {
            url: '/posts',
            views: {
                'mainContent': {
                    templateUrl: 'post/post.html',
                    controller: 'PostController'
                }
            }
        })
        .state('user.postDetail', {
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
    $urlRouterProvider.otherwise('user/posts');
    $locationProvider.html5Mode(true);

    $authProvider.configure({
        apiUrl: '',
        authProviderPaths: {
            github:   '/auth/github',
            facebook: '/auth/facebook',
            google:   '/auth/google_oauth2'
        }
    })
});