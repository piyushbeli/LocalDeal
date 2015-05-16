appVendor.controller("OfferDetailController", function ($scope, offer, OfferService, $state, ReferenceDataCache,
                                                        CacheKeys) {
    $scope.offer = offer;
    $scope.data = {};

    ReferenceDataCache.get(CacheKeys.OfferTypes)
        .then(function(offerTypes) {
            $scope.data.offerTypes = offerTypes;
        })

    $scope.saveOffer = function() {
        OfferService.saveOffer($scope.deal.id, offer)
            .then(function(offer) {
                $scope.deal.offers.push(offer);
                $state.go('app.dealDetail', {id: $scope.deal.id});
            })
            .catch(function(errorMessage) {
                alert(errorMessage);
            })
    };

})