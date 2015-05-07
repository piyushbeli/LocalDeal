appVendor.constant("Routes", {
    login: {
        url: '/login',
        views: {
            'navContent': {
                templateUrl: 'vendor/login/login.html',
                controller: 'LoginController'
            }
        }
    },
    root: {
        url: '/app',
        abstract: true,
        views: {
            'navContent': {
                templateUrl: 'vendor/nav/nav.html',
                controller: 'NavController'
            }
        },
        resolve: {
            vendor: function ($auth, $state, $q) {
                /*var deferred = $q.defer();
                $auth.validateUser()
                    .then(function(user) {
                        deferred.resolve(user);
                    })
                 .catch(function(response) {
                        $state.go('login');
                 deferred.reject(response.errors.full_messages.join('\n'));
                    })
                 return deferred.promise;*/
                $auth.validateToken();
            }
        }
    },
    deals: {
        url: '/deals',
        views: {
            'mainContent': {
                templateUrl: 'vendor/deal/dealList.html',
                controller: 'DealListController'
            }
        }
    },
    addresses: {
        url: '/addresses',
        views: {
            'mainContent': {
                templateUrl: 'vendor/address/addressList.html',
                controller: 'AddressController'
            }
        }
    },
    dealDetail: {
        url: '/deals/:id',
        views: {
            'mainContent': {
                templateUrl: 'vendor/deal/dealDetail.html',
                controller: 'DealDetailController'
            }
        }
    },
    emailConfirmation: {
        url: '/emailConfirmation',
        views: {
            'navContent': {
                templateUrl: 'vendor/login/emailConfirmation.html'
            }
        }
    },
    accountDetail: {
        url: '/account',
        views: {
            'mainContent': {
                templateUrl: 'vendor/account/profile.html',
                controller: 'AccountController'
            }
        }
    }
})