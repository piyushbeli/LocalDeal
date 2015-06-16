appVendor.constant("Routes", {
    login: {
        url: '/vendor/login',
        views: {
            'navContent': {
                templateUrl: 'vendor/login/login.html',
                controller: 'LoginController'
            }
        }
    },
    root: {
        url: '/vendor/app',
        abstract: true,
        views: {
            'navContent': {
                templateUrl: 'vendor/nav/nav.html',
                controller: 'NavController'
            }
        },
        resolve: {
            vendor: ['$auth', '$q', '$state', 'Vendor', '$rootScope', function ($auth, $q, $state, Vendor, $rootScope) {
                var deferred = $q.defer();
                $auth.validateUser()
                    .then(function(response) {
                        $rootScope.vendor = Vendor.build(response);
                        deferred.resolve($rootScope.vendor);
                    })
                    .catch(function(response) {
                        $state.go('login');
                    })
                return deferred.promise;
            }]
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
            deal: ['DealService', '$stateParams', function(DealService, $stateParams) {
                var dealId = $stateParams['id'];
                if (dealId == 'new') {
                    return DealService.newDeal();
                } else {
                    return DealService.fetchDealDetails(dealId);
                }
            }]
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
            deal: ['DealService', function(DealService) {
                return DealService.newDeal();
            }]
        }
    },
    offerDetail: {
        url: '/offers/:offer_id',
        params: {offer: null},
        views: {
            'offerDetailContent': {
                templateUrl: 'vendor/deal/offer/offerDetail.html',
                controller: 'OfferDetailController'
            }
        },
        resolve: {
            offer: ['$stateParams', 'OfferService', 'deal', function($stateParams, OfferService, deal) {
                var offer = $stateParams['offer'];
                if (offer) {
                    return offer;
                } else {
                    var offerId = $stateParams['offer_id'];
                    if (offerId == 'new') {
                        return OfferService.newOffer();
                    } else {
                        return deal.offers.find({id: offerId})
                    }
                }
            }]
        }
    },
    newOffer: {
        url: '/offers/new',
        views: {
            'offerDetailContent': {
                templateUrl: 'vendor/deal/offer/offerDetail.html',
                controller: 'OfferDetailController'
            }
        },
        resolve: {
            offer: ['OfferService', function(OfferService) {
                return OfferService.newOffer();
            }]
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
    },
    outlets: {
        url: '/outlets',
        views: {
            'mainContent': {
                templateUrl: 'vendor/outlet/outletList.html'
            }
        }
    },
    outletDetail: {
        url: '/outlets/:id',
        views: {
            'mainContent': {
                templateUrl: 'vendor/outlet/outletDetail.html',
                controller: 'OutletDetailController'
            }
        },
        resolve: {
            outlet: ['$stateParams', 'OutletService', 'vendor', function($stateParams, OutletService, vendor) {
                var outlet = $stateParams['outlet'];
                if (outlet) {
                    return outlet;
                } else {
                    var outletId = $stateParams['id'];
                    if (outletId == 'new') {
                        return OutletService.newOutlet();
                    } else {
                        return vendor.outlets.find({id: outletId});
                    }
                }
            }]
        }
    },
    newOutlet: {
        url: '/outlets/new',
        views: {
            'mainContent': {
                templateUrl: 'vendor/outlet/outletDetail.html',
                controller: 'OutletDetailController'
            }
        },
        resolve: {
            outlet: ['OutletService', function(OutletService) {
                return OutletService.newOutlet();
            }]
        }
    }

})