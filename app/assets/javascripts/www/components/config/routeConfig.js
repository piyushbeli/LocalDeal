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
            outlet: ['OutletService', '$stateParams', '$state', function (OutletService, $stateParams, $state) {
                return OutletService.fetchOutletDetail($stateParams['id']);
            }]
        }
    },

    deals: {
        url: '/deals',
        views: {
            'outletDealContent': {
                templateUrl: 'user/deal/dealList.html',
                controller: 'DealListController'
            }
        }
    },

    dealDetail: {
        url: '/deals/:deal_id',
        views: {
            'outletDealContent': {
                templateUrl: 'user/deal/dealDetail.html',
                controller: 'DealDetailController'
            }
        },
        resolve: {
            deal: ['outlet', '$stateParams', function(outlet, $stateParams) {
                return outlet.findDeal($stateParams['deal_id']);
            }]
        }
    },

    orders: {
        url: '/orders',
        views: {
            'mainContent': {
                templateUrl: 'user/order/orderList.html',
                controller: 'OrderListController'
            }
        }
    },

    orderDetail: {
        url: '/orders/:order_no',
        views: {
            'mainContent': {
                templateUrl: 'user/order/orderDetail.html',
                controller: 'OrderDetailController'
            }
        },
        resolve: {
            order: ['OrderService', '$stateParams', function(OrderService, $stateParams) {
                return OrderService.fetchOrderDetail($stateParams['order_no']);
            }]
        }
    },

    profile: {
        url: '/profile',
        views: {
            'mainContent': {
                templateUrl: 'user/account/profile.html',
                controller: 'AccountController'
            }
        }
    },

    favoriteOutlets: {
        url: '/favorites',
        views: {
            'mainContent': {
                templateUrl: 'user/outlet/favoriteOutletList.html',
                controller: 'FavoriteOutletListController'
            }
        }
    }
})