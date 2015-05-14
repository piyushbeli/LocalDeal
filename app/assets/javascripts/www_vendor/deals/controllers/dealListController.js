appVendor.controller("DealListController", function($scope, $state, DealService) {
    $scope.data = {};
    DealService.fetchDealList()
        .then(function(deals) {
            $scope.data.deals = deals;
        })
        .catch(function(errorMessage) {
            alert(errorMessage);
        });

    $scope.openDealDetail = function(deal) {
        $state.go('app.dealDetail', {id: deal.id});
    };


})