appVendor.constant("Routes", {
    verifyLogin: {
        //This state will be used to redirect the user to login or deals state based on login status
        url: '/verifyLogin',
        views: {
            'navContent': {
                templateUrl: 'vendor/login/verifyLogin.html',
                controller: 'VerifyLoginController'
            }
        }
    },
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
        }
    },
    deals: {
        url: '/deals',
        views: {
            'navContent': {
                templateUrl: 'vendor/deal/dealList.html',
                controller: 'DealListController'
            }
        }
    },
    addresses: {
        url: '/addresses',
        views: {
            'navContent': {
                templateUrl: 'vendor/address/addressList.html',
                controller: 'AddressController'
            }
        }
    },
    dealDetail: {
        url: '/deals/:id',
        views: {
            'navContent': {
                templateUrl: 'vendor/deal/dealDetail.html',
                controller: 'DealDetailController'
            }
        }
    }
})