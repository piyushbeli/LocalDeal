appVendor.controller("DealDetailController", ['$scope', '$state', '$rootScope', '$stateParams', 'DealService', 'deal',
    'States', '$modal',
    function ($scope, $state, $rootScope, $stateParams, DealService, deal, States, $modal) {
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
        };

        $scope.openOutletSelectionModal = function () {
            var modalInstance = $modal.open({
                animation: true,
                templateUrl: 'vendor/deal/selectOutlets.html',
                controller: 'AddOutletController',
                resolve: {
                    deal: function() {
                        return $scope.deal;
                    }
                }
            });
            modalInstance.result.then(function (selectedOutlets) {
                $scope.deal.outlets = $scope.deal.outlets.concat($rootScope.vendor.outlets.find(selectedOutlets));
            })
        };

    }])
    .controller('AddOutletController', ['$rootScope', '$scope', '$modalInstance', 'DealService', 'deal',
        function ($rootScope, $scope, $modalInstance, DealService, deal) {
            $scope.selectedOutlets = [];
            $scope.deal = deal;

            $scope.addSelectedOutlets = function () {
                DealService.addOutlets(deal, $scope.selectedOutlets)
                    .then(function() {
                        $modalInstance.close($scope.selectedOutlets);
                    })
                    .catch(function(errorMessage) {
                        alert(errorMessage);
                    })
            };
            $scope.cancel = function () {
                $modalInstance.dismiss('cancel');
            }
        }])