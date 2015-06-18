appUser.service("DealService", ['$http', '$q', 'HttpRoutes', 'Review', function($http, $q, HttpRoutes) {
    var self = this;

    self.buyOffer = function(offer, outlet) {
        var deferred = $q.defer(),
            url = HttpRoutes.buyOffer.format({id: offer.id}),
            postData = {
                outlet_id: outlet.id
            };

        $http.post(url, postData)
            .then(function(response) {
                deferred.resolve(response.data.order_no);
            })
            .catch(function(response) {
                var errorMessage = response.message || response.data.errors.join("\n");
                deferred.reject(errorMessage);
            });
        return deferred.promise;
    };
}])