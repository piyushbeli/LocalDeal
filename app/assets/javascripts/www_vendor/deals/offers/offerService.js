appVendor.service("OfferService", ['Offer', '$q', '$http', 'HttpRoutes', function(Offer, $q, $http, HttpRoutes) {
    var self = this;

    self.newOffer = function() {
        return new Offer();
    }

    self.saveOffer = function(dealId, offer) {
        if (offer.isNew()) {
            return self.createOffer(dealId, offer);
        } else {
            return self.updateOffer(dealId, offer);
        }
    };

    self.createOffer = function(dealId, offer) {
        var deferred = $q.defer(),
            url = HttpRoutes.offer.format({
                deal_id: dealId
            }),
            postData = {
                offer_type_id: offer.offerType.id,
                discount: offer.discount,
                what_you_get: offer.whatYouGet,
                fine_print: offer.finePrint.split("\n"),
                instruction: offer.instruction,
                max_no_of_coupons: offer.maxCoupons,
                start_at: offer.startAt,
                end_at: offer.endAt,
                expire_at: offer.expireAt,
                actual_price: offer.actualPrice,
                offered_price: offer.offeredPrice
            };

        $http.post(url, postData)
            .then(function(response) {
                deferred.resolve(Offer.build(response.data));
            })
            .catch(function (response) {
                var errorMessage = response.data.errors.join("\n");
                deferred.reject(errorMessage);
            });
        return deferred.promise;
    };

    self.updateOffer = function(dealId, offer) {
        var deferred = $q.defer(),
            url = HttpRoutes.offer.format({
                deal_id: dealId
            }),
            url = url + "/" + offer.id,
            postData = {
                offer_type_id: offer.offerType.id,
                discount: offer.discount,
                what_you_get: offer.whatYouGet,
                fine_print: offer.finePrint.split("\n"),
                instruction: offer.instruction,
                max_no_of_coupons: offer.maxCoupons,
                start_at: offer.startAt,
                end_at: offer.endAt,
                expire_at: offer.expireAt,
                actual_price: offer.actualPrice,
                offered_price: offer.offeredPrice
            };

        $http.put(url, postData)
            .then(function(response) {
                deferred.resolve(Offer.build(response.data));
            })
            .catch(function (response) {
                var errorMessage = response.data.errors.join("\n");
                deferred.reject(errorMessage);
            });
        return deferred.promise;
    };
}])