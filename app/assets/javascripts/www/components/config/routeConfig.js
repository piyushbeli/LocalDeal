appUser.constant("Routes", {
    login: {
        url: '/login',
        views: {
            'navContent': {
                templateUrl: 'user/nav/login.html',
                controller: 'LoginController'
            }
        }
    },
    root: {
        url: '/app',
        abstract: true,
        views: {
            'navContent': {
                templateUrl: 'user/nav/nav.html',
                controller: 'NavController'
            }
        }
    },
    outlets: {
        url: '/outlets',
        views: {
            'mainContent': {
                templateUrl: 'user/outlet/outletList.html',
                controller: 'OutletListController'
            }
        },
        resolve: {
            setTitle: function($window, Constants) {
                $window.document.title = $window.document.title + " - Outlets"
            }
        }
    },
    outletDetail: {
        url: '/outlets/:id',
        views: {
            'mainContent': {
                templateUrl: 'user/outlet/outletDetail.html',
                controller: 'OutletDetailController'
            }
        },
        resolve: {
            outlet: function (OutletService, $stateParams) {
                return OutletService.fetchOutletDetails(dealId);
            }
        }
    },

    profile: {
        url: '/profile',
        views: {
            'mainContent': {
                templateUrl: 'vendor/account/profile.html',
                controller: 'AccountController'
            }
        }
    }
})