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

            });

        //End
        return deferred.promise;
    };

    self.fetchOutletDetail = function(id) {
        var deferred = $q.defer(),
            url = HttpRoutes.outletDetail.format({id: id});
    };

    self.newSearchCriteria = function() {
        return new SearchCriteria();
    }

})