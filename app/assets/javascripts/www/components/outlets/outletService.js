appUser.service("OutletService", ['$http', '$q', 'HttpRoutes', 'Outlet', 'CommonCache', 'CacheKeys', '$location',
    'Geocoder', 'LoginService', 'LocationService',
    function ($http, $q, HttpRoutes, Outlet, CommonCache, CacheKeys, $location, Geocoder, LoginService, LocationService) {
        var self = this;

        self.fetchOutlets = function (criteria, pageNo) {
            var deferred = $q.defer(),
                url = null;
            $location.search(criteria.clientSideQueryString());

            criteria.toQueryString().then(function (promise) {
                return promise;
            }).then(function (queryString) {
                var url = HttpRoutes.outlets + queryString + "&page=" + pageNo;
                return $http.get(url);
            })
                .then(function (response) {
                    deferred.resolve(Outlet.build(response.data))
                })
                .catch(function (response) {
                    var errorMessage = response.data.errors.join("\n");
                    deferred.reject(errorMessage);
                });

            //End
            return deferred.promise;
        };

        self.fetchOutletDetail = function (id) {
            var deferred = $q.defer();
            LocationService.getCurrentLocation()
                .then(function(location) {
                    var url = HttpRoutes.outlets + "/" + id + "?current_location=" + location;
                    return $http.get(url);
                })
                .then(function (response) {
                    deferred.resolve(Outlet.build(response.data));
                })
                .catch(function (response) {
                    var errorMessage = response.data.errors.join("\n");
                    deferred.reject(errorMessage);
                })
            return deferred.promise;
        };

        self.reportSpam = function (outlet, reason) {
            var deferred = $q.defer(),
                url = HttpRoutes.spamVendor.format({vendor_id: outlet.vendor.id}),
                postData = {
                    reason: reason
                };
            $http.post(url, postData)
                .then(function (response) {
                    deferred.resolve();
                })
                .catch(function (response) {
                    var errorMessage = response.data.errors.join("\n");
                    deferred.reject(errorMessage);
                })
            return deferred.promise;
        };

        self.unSpam = function (outlet) {
            var deferred = $q.defer(),
                url = HttpRoutes.spamVendor.format({vendor_id: outlet.vendor.id});

            $http.delete(url)
                .then(function (response) {
                    deferred.resolve();
                })
                .catch(function (response) {
                    var errorMessage = response.data.errors.join("\n");
                    deferred.reject(errorMessage);
                })
            return deferred.promise;
        };

        self.toggleFavorite = function (outlet) {
            var url = HttpRoutes.markAsFavorite.format({id: outlet.id});
            if (outlet.markedAsFavorite) {
                return $http.delete(url);
            } else {
                return $http.post(url);
            }
        };

        self.fetchFavoriteOutlets = function () {
            var  deferred = $q.defer();
            LocationService.getCurrentLocation()
                .then(function(location) {
                    var url = HttpRoutes.favoriteOutlets + "?current_location=" + location;
                    return $http.get(url);
                })
                .then(function(response) {
                    deferred.resolve(Outlet.build(response.data));
                })
                .catch(function(response) {
                    var errorMessage = response.data.errors.join("\n");
                    deferred.reject(errorMessage);
                })
            return deferred.promise;
        }

    }])