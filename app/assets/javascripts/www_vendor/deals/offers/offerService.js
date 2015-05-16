appVendor.service("OfferService", function(Offer) {
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
            url = HttpRoutes.offers.format({
                deal_id: deal.id
            });

        $http.post(url, offer)
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
            url = HttpRoutes.offers.format({
                deal_id: deal.id
            });

        $http.put(url, offer)
            .then(function(response) {
                deferred.resolve(Offer.build(response.data));
            })
            .catch(function (response) {
                var errorMessage = response.data.errors.join("\n");
                deferred.reject(errorMessage);
            });
        return deferred.promise;
    };
})