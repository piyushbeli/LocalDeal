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
            auth: function ($auth, $q, $state, Vendor, $rootScope) {
                var deferred = $q.defer();
                $auth.validateUser()
                    .then(function(response) {
                        $rootScope.vendor = Vendor.build(response);
                        deferred.resolve();
                    })
                    .catch(function(response) {
                        $state.go('login');
                    })
                return deferred.promise;
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
        },
        resolve: {
            deal: function(DealService, $stateParams) {
                var dealId = $stateParams['id'];
                if (dealId == 'new') {
                    return DealService.newDeal();
                } else {
                    return DealService.fetchDealDetails(dealId);
                }
            }
        }
    },
    newDeal: { //This is same as dealDetail but id has been hardcoded to 'new'
        url: '/deals/new',
        views: {
            'mainContent': {
                templateUrl: 'vendor/deal/dealDetail.html',
                controller: 'DealDetailController'
            }
        },
        resolve: {
            deal: function(DealService) {
                return DealService.newDeal();
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