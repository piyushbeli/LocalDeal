appUser.controller("FavoriteOutletListController", ['$scope', '$rootScope', 'OutletService', '$state', 'States',  function($scope, $rootScope, OutletService, $state, States) {

    OutletService.fetchFavoriteOutlets()
        .then(function(response) {
            $scope.outlets = response.items;
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
        $state.go(States.deals, {id: outlet.id});
    }

}])