appVendor.service("DealService", ['Deal', 'Offer', '$q', '$http', 'HttpRoutes', '$interpolate',
    function (Deal, Offer, $q, $http, HttpRoutes, $interpolate) {
        var self = this;

        self.fetchDealList = function () {
            var deferred = $q.defer(),
                url = HttpRoutes.deal;

            $http.get(url)
                .then(function (response) {
                    deferred.resolve(Deal.build(response.data));
                })
                .catch(function (response) {
                    var errorMessage = response.data.errors.join("\n");
                    deferred.reject(errorMessage);
                })
            return deferred.promise;
        };

        self.newDeal = function () {
            return new Deal();
        };

        self.fetchDealDetails = function (id) {
            var deferred = $q.defer(),
                url = HttpRoutes.deal + "/" + id;

            $http.get(url)
                .then(function (response) {
                    deferred.resolve(Deal.build(response.data));
                })
                .catch(function (response) {
                    var errorMessage = response.data.errors.join("\n");
                    deferred.reject(errorMessage);
                });
            return deferred.promise;
        };

        self.saveDeal = function (deal) {
            if (deal.isNew()) {
                return self.createDeal(deal);
            } else {
                return self.updateDeal(deal);
            }
        }

        self.createDeal = function (deal) {
            var deferred = $q.defer(),
                url = HttpRoutes.deal

            $http.post(url, deal)
                .then(function (response) {
                    deferred.resolve(Deal.build(response.data));
                })
                .catch(function (response) {
                    var errorMessage = response.data.errors.join("\n");
                    deferred.reject(errorMessage);
                });
            return deferred.promise;
        };

        self.updateDeal = function (deal) {
            var deferred = $q.defer(),
                url = HttpRoutes.deal + "/" + deal.id,
                postData = {
                    title: deal.title,
                    description: deal.description
                };

            $http.put(url, postData)
                .then(function (response) {
                    deferred.resolve(Deal.build(response.data));
                })
                .catch(function (response) {
                    var errorMessage = response.data.errors.join("\n");
                    deferred.reject(errorMessage);
                });
            return deferred.promise;
        };

        self.removeOutlet = function (deal, outlet) {
            var deferred = $q.defer(),
                url = HttpRoutes.removeOutlet.format({
                    deal_id: deal.id,
                    outlet_id: outlet.id
                });
            $http.delete(url)
                .then(function (response) {
                    deferred.resolve();
                })
                .catch(function (response) {
                    var errorMessage = response.data.errors.join("\n");
                    deferred.reject(errorMessage);
                });
            return deferred.promise;
        };

        self.addOutlets = function (deal, outlets) {
            var deferred = $q.defer(),
                outlets = outlets.map(function(item) {
                    return item.id;
                }),
                url = HttpRoutes.addOutlets.format({
                    deal_id: deal.id
                }),
                postData = {
                    outlets: outlets
                };
            $http.put(url, postData)
                .then(function (response) {
                    deferred.resolve();
                })
                .catch(function (response) {
                    var errorMessage = response.data.errors.join("\n");
                    deferred.reject(errorMessage);
                });
            return deferred.promise;
        };

        //End
    }])