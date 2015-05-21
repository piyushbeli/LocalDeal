appUser.controller("OutletListController", function($scope, $rootScope, $window, OutletService, States, Utils, ReferenceDataCache, CacheKeys ) {
    $window.document.title = $window.document.title + " - Outlets";
    $scope.criteria = OutletService.newSearchCriteria();
    $scope.criteria.currentLocation = $rootScope.currentLocation;
    $scope.googlePlaceAutoCompleteOptionsCity = Utils.googlePlaceAutoCompleteOptionsCity();
    $scope.googlePlaceAutoCompleteOptionsStreet = Utils.googlePlaceAutoCompleteOptionsStreet( $scope.criteria.getStreetBoundary());

    //NavController is ditching many times so making sure that we have current location here.
    navigator.geolocation.getCurrentPosition(function (position) {
        $scope.criteria.currentLocation = [position.coords.latitude, position.coords.longitude];
    });

    $scope.data= {};
    ReferenceDataCache.get(CacheKeys.Categories)
        .then(function (categories) {
            $scope.data.categories = categories;
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
        OutletService.fetchOutlets($scope.criteria, $scope.criteria.pageNo++)
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


    $scope.showOutletDetail = function(outlet) {
        $state.go(States.outletDetail, {id: outlet.id});
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
})