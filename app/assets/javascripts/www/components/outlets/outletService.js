appUser.service("OutletService", function($http, $q, HttpRoutes, SearchCriteria, Outlet) {
    var self = this;

    self.fetchOutlets = function(criteria, pageNo) {
        var deferred = $q.defer(),
            url = HttpRoutes.outlets + criteria.toQueryString() + "&page=" + pageNo;

        $http.get(url)
            .then(function(response) {
                deferred.resolve(Outlet.build(response.data))
            })
            .catch(function(response) {
                var errorMessage = response.errors.full_messages.join("\n");
                deferred.reject(errorMessage);
            });

        //End
        return deferred.promise;
    };

    self.fetchOutletDetail = function(id, current_location) {
        var deferred = $q.defer(),
            url = HttpRoutes.outlets + "/" + id + "?current_location=" + current_location;
        $http.get(url)
            .then(function(response) {
                deferred.resolve(Outlet.build(response.data));
            })
            .catch(function(response) {
                var errorMessage = response.errors.full_messages.join("\n");
                deferred.reject(errorMessage);
            })
        return deferred.promise;
    };

    self.newSearchCriteria = function() {
        return new SearchCriteria();
    }

})