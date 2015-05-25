appUser.controller("DealListController", function($scope, $rootScope, $state, $window, DealService, States, outlet) {
    $scope.outlet = outlet;
    if (outlet) {
        $window.document.title = $window.document.title + outlet.name;
    }
    $scope.showDetailDetail = function(deal) {
        $state.go(States.dealDetail, {id: deal.id});
    }
})