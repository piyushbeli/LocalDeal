appVendor.controller("OfferDetailController", ['$scope', 'deal', 'offer', 'OfferService', '$state', 'ReferenceDataCache',
    'CacheKeys',
    function ($scope, deal, offer, OfferService, $state, ReferenceDataCache, CacheKeys, $modal) {
        $scope.deal = deal; //Injected by app.deatDetail state via resolve
        $scope.offer = offer;
        $scope.data = {
            minDate: new Date(),
            maxDate: moment().add(7, 'day').toDate(),
            dateOptions: {
                startingDay: 1,
                showWeeks: false
            },
            showMeridian: true,
            hourStep: 1,
            minuteStep: 5
        };

        ReferenceDataCache.get(CacheKeys.OfferTypes)
            .then(function (offerTypes) {
                $scope.data.offerTypes = offerTypes;
                //Set the reference of offer type from the above array
                $scope.offer.offerType = $scope.data.offerTypes.find(offer.offerType);
            });

        $scope.saveOffer = function () {
            OfferService.saveOffer($scope.deal.id, offer)
                .then(function (anOffer) {
                    offer.isNew() ? $scope.deal.offers.push(anOffer) : null
                    $state.go('app.dealDetail', {id: $scope.deal.id});
                })
                .catch(function (errorMessage) {
                    alert(errorMessage);
                });
        };

        $scope.cancel = function () {
            $state.go('app.dealDetail', {id: $scope.deal.id});
        };

        $scope.toggleOffer = function () {
            OfferService.toggleOfferState($scope.deal.id, offer)
                .then(function() {
                    $state.go('app.dealDetail', {id: $scope.deal.id});
                })
                .catch(function (errorMessage) {
                    alert(errorMessage);
                });
        };
    }])
