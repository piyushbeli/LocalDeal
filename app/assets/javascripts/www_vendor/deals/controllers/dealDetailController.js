appVendor.controller("DealDetailController", function($scope, $state, $rootScope, $stateParams, DealService, deal) {
    $scope.deal = deal;

    $scope.saveDeal = function() {
        DealService.saveDeal($scope.deal)
            .then(function(deal) {
                $rootScope.vendor.deals.push(deal);
            })
            .catch(function(errorMessage) {
                alert(errorMessage);
            })
    };

    $scope.removeOutlet = function(outlet) {
        DealService.removeOutlet($scope.deal, outlet)
            .then(function(response) {
                $scope.deal.outlets.delete(outlet.id);
            })
            .catch(function(errorMessage) {
                alert(errorMessage);
            })
    }
})