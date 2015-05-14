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

    $scope.removeOutlet = function() {

    }
})