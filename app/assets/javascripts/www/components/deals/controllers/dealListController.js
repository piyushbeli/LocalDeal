appUser.controller("DealListController", function($scope, $rootScope, $state, DealService, States) {
    $scope.showDetailDetail = function(deal) {
        $state.go(States.dealDetail, {id: deal.id});
    }
})