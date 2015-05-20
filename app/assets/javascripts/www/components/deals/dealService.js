appUser.service("DealService", function($http, $q, HttpRoutes) {
    var self = this;

    self.fetchDeals = function(criteria, currentLocation) {
        var deferred = $q.defer(),
            params = {
                city_id: criteria.cityId,
                category_id: criteria.category_id,
                subcategory_ids: criteria.subcategories.map(function(item) {
                    return item.id
                }),
                current_location: currentLocation,
                street_location: criteria.street_location,
                show_near_by: criteria.showNearBy
            },
            url = HttpRoutes.deals.format(params);

        $http.get(url)
            .then(function(response) {
                deferred.resolve(Deal.build(response.data))
            })
            .catch(function(response) {

            })
    }
    self.fetchDetailDetail = function() {

    }
})