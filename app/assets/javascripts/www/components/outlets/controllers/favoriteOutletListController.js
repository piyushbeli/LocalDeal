appUser.controller("FavoriteOutletListController", ['$scope', '$rootScope', 'OutletService', '$state', 'States',  function($scope, $rootScope, OutletService, $state, States) {

    OutletService.fetchFavoriteOutlets()
        .then(function(outlets) {
            $scope.outlets = outlets;
        })
        .catch(function(errorMessage) {
            alert(errorMessage);
        });

    $scope.toggleFavorite = function(outlet) {
        OutletService.toggleFavorite(outlet)
            .then(function() {
                $scope.outlets.remove(outlet);
            })
    };

    $scope.showOutletDetail = function(outlet) {
        $state.go(States.outletDetail, {id: outlet.id});
    }

}])