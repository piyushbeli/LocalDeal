appVendor.controller("DealDetailController", ['$scope', '$state', '$rootScope', '$stateParams', 'DealService', 'deal', 'States',
    function ($scope, $state, $rootScope, $stateParams, DealService, deal, States) {
        $scope.deal = deal;

        $scope.saveDeal = function () {
            DealService.saveDeal($scope.deal)
                .then(function (deal) {
                    $rootScope.vendor.deals.push(deal);
                })
                .catch(function (errorMessage) {
                    alert(errorMessage);
                })
        };

        $scope.cancel = function () {
            $state.go(States.deals);
        };

        $scope.removeOutlet = function (outlet) {
            DealService.removeOutlet($scope.deal, outlet)
                .then(function (response) {
                    $scope.deal.outlets.delete(outlet.id);
                })
                .catch(function (errorMessage) {
                    alert(errorMessage);
                })
        };

        $scope.editOffer = function (offer) {
            $state.go(States.offerDetail, {offer_id: offer.id, offer: offer});
        }
    }])