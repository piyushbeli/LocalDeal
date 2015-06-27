appUser.controller("OutletListController", ['$scope', '$rootScope', '$state', '$location', '$window', 'OutletService', 'States',
    'Utils', 'ReferenceDataCache', 'CacheKeys', 'CommonCache', 'SearchCriteria', 'LoginService', 'LocationService', 'CommonConstants',
    function ($scope, $rootScope, $state, $location, $window, OutletService, States, Utils, ReferenceDataCache,
              CacheKeys, CommonCache, SearchCriteria, LoginService, LocationService, CommonConstants) {

        $window.document.title = "Outlets | " + CommonConstants.appName;
        $scope.criteria = SearchCriteria.instanceFromQueryString($location.search());
        $scope.criteria.page = $scope.criteria.page || 1;
        $scope.itemsPerPage = CommonConstants.ItemsPerPage;


        $scope.criteria.currentLocation = $rootScope.currentLocation;
        $scope.googlePlaceAutoCompleteOptionsCity = Utils.googlePlaceAutoCompleteOptionsCity();
        $scope.googlePlaceAutoCompleteOptionsStreet = Utils.googlePlaceAutoCompleteOptionsStreet();
        $scope.data = {};

        //NavController is ditching many times so making sure that we have current location here.
        LocationService.getCurrentLocation(function (location) {
            $scope.criteria.currentLocation = location;
        });

        $scope.refreshItems = function () {
            if (!$scope.criteria.qualifyForSearch()) {
                return;
            }
            OutletService.fetchOutlets($scope.criteria)
                .then(function (response) {
                    $scope.criteria.outlets = response.items;
                    $scope.totalItems = response.totalItems;
                })
                .catch(function (errorMessage) {
                    alert(errorMessage);
                });
        };
        $scope.refreshItems();
/*
        $scope.loadMore = function () {
            if ($scope.criteria.busy || !$scope.criteria.outlets.notEmpty()) {
                return;
            }
            $scope.criteria.busy = true;
            OutletService.fetchOutlets($scope.criteria, ++$scope.criteria.pageNo)
                .then(function (outlets) {
                    $scope.criteria.outlets = $scope.criteria.outlets.concat(outlets);
                    if (!outlets.notEmpty()) {
                        $scope.criteria.showLoading = false;
                    } else {
                        $scope.criteria.busy = false;
                    }
                })
                .catch(function (errorMessage) {
                    alert(errorMessage);
                });
        };*/

        $scope.toggleFavorite = function (outlet) {
            if (!$rootScope.isLoggedIn()) {
                LoginService.openLoginDialog();
                return;
            }
            OutletService.toggleFavorite(outlet)
                .then(function (response) {
                    $rootScope.data.favoriteOutletsCount++;
                    outlet.markedAsFavorite = !outlet.markedAsFavorite;
                })
                .catch(function (errorMessage) {
                    alert(errorMessage);
                })
        };

        ReferenceDataCache.get(CacheKeys.Categories)
            .then(function (categories) {
                $scope.data.categories = categories;
                if ($scope.criteria.category) {
                    $scope.criteria.category = $scope.data.categories.find($scope.criteria.category);
                }
                if ($scope.criteria.category && $scope.criteria.subcategories.notEmpty()) {
                    $scope.criteria.subcategories = $scope.criteria.category.subcategories.find($scope.criteria.subcategories);
                }
                //This statement should be below fetchOutlets() method. I know it's a hack but it will make the life very easy
                //for loading the outlets when somebody hits refresh.
                if ($scope.criteria.qualifyForSearch()) {
                    $scope.fetchOutlets();
                }
            });


        $scope.showOutletDetail = function (outlet) {
            $state.go(States.deals, {id: outlet.id});
        };

        $scope.$watch('criteria.street', function (newVal, oldVal) {
            if (newVal == null || newVal.trim() == "") {
                $scope.criteria.streetLocationDetail = null;
            }
        });
        $scope.$watch('criteria.city', function (newVal, oldVal) {
            if (newVal == null || newVal.trim() == "") {
                $scope.criteria.cityDetail = null;
            }
        });
        $scope.$watch('criteria.category', function (newVal, oldVal) {
            if ((newVal && oldVal) && (newVal.slug != oldVal.slug)) {
                $scope.criteria.subcategories = [];
            }
        });

    }])