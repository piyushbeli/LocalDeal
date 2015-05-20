appUser.controller("OutletListController", function($scope, $rootScope, OutletService, States, Utils, ReferenceDataCache, CacheKeys ) {
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
        OutletService.fetchOutlets($scope.criteria, $rootScope.currentLocation)
            .then(function(outlets) {
                $scope.outlets = outlets;
            })
            .catch(function(errorMessage) {
                alert(errorMessage);
            });
    };

    $scope.showOutletDetail = function(outlet) {
        $state.go(States.outletDetail, {id: outlet.id});
    }
})