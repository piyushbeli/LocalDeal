appUser.controller("OutletListController", function($scope, $rootScope, $state, $location, $window, OutletService, States,
                                                    Utils, ReferenceDataCache, CacheKeys , CommonCache, SearchCriteria) {
    $window.document.title = $window.document.title + " - Outlets";
    $scope.criteria = SearchCriteria.instanceFromQueryString($location.search());

    $scope.criteria.currentLocation = $rootScope.currentLocation;
    $scope.googlePlaceAutoCompleteOptionsCity = Utils.googlePlaceAutoCompleteOptionsCity();
    $scope.googlePlaceAutoCompleteOptionsStreet = Utils.googlePlaceAutoCompleteOptionsStreet();
    $scope.data= {};

    //NavController is ditching many times so making sure that we have current location here.
    navigator.geolocation.getCurrentPosition(function (position) {
        $scope.criteria.currentLocation = [position.coords.latitude, position.coords.longitude];
    });

    $scope.fetchOutlets = function() {
        $scope.criteria.pageNo = 1;
        $scope.criteria.busy = false;
        OutletService.fetchOutlets($scope.criteria, $scope.criteria.pageNo)
            .then(function(outlets) {
                $scope.criteria.outlets = outlets;
            })
            .catch(function(errorMessage) {
                alert(errorMessage);
            });
    };

    $scope.loadMore = function() {
        if ($scope.criteria.busy || !$scope.criteria.outlets.notEmpty()) {
            return;
        }
        $scope.criteria.busy = true;
        OutletService.fetchOutlets($scope.criteria, ++$scope.criteria.pageNo)
            .then(function(outlets) {
                $scope.criteria.outlets = $scope.criteria.outlets.concat(outlets);
                if (!outlets.notEmpty()) {
                    $scope.criteria.showLoading = false;
                } else {
                    $scope.criteria.busy = false;
                }
            })
            .catch(function(errorMessage) {
                alert(errorMessage);
            });
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


    $scope.showOutletDetail = function(outlet) {
        $state.go(States.deals, {id: outlet.id});
    };

    $scope.$watch('criteria.street', function(newVal, oldVal) {
        if (newVal == null || newVal.trim() == "") {
            $scope.criteria.streetLocationDetail = null;
        }
    });
    $scope.$watch('criteria.city', function(newVal, oldVal) {
        if (newVal == null || newVal.trim() == "") {
            $scope.criteria.cityDetail = null;
        }
    });
    $scope.$watch('criteria.category', function(newVal, oldVal) {
        if ((newVal && oldVal) && (newVal.slug != oldVal.slug)) {
            $scope.criteria.subcategories = [];
        }
    });

})