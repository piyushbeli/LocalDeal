appUser.controller("DealListController", function($scope, $rootScope, $state, DealService, States, outlet) {
    $scope.outlet = outlet;
    $scope.showDetailDetail = function(deal) {
        $state.go(States.dealDetail, {id: deal.id});
    }
})