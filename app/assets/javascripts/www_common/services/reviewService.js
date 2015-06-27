appCommon.service("ReviewService", ['$q', 'HttpRoutes', '$http', 'Review', function($q, HttpRoutes, $http, Review) {
    var self = this;

    self.submitReview = function(outlet, review) {
        var deferred = $q.defer(),
            url = HttpRoutes.outletReviews.format({outlet_id: outlet.id});
        $http.post(url, review)
            .then(function(response) {
                deferred.resolve(Review.build(response.data));
            })
            .catch(function(response) {
                var errorMessage = response.message || response.data.errors.join("\n");
                deferred.reject(errorMessage);
            });
        return deferred.promise;
    };

    self.refreshItems = function(outlet, page) {
        var deferred = $q.defer(),
            url = HttpRoutes.outletReviews.format({outlet_id: outlet.id}) + "?per_page=10&page=" + page;
        $http.get(url)
            .then(function(response) {
                var result = {
                    items: Review.build(response.data.items),
                    totalItems: response.data.total_items
                };
                deferred.resolve(result);
            })
        return deferred.promise;
    };

    self.postComment = function(review, comment) {
        var deferred = $q.defer(),
            url = HttpRoutes.postComment.format({comment_id: review.id});

        $http.post(url, comment)
            .then(function(response) {
                deferred.resolve(Review.build(response.data));
            })
            .catch(function(response) {
                var errorMessage = response.message || response.data.errors.join("\n");
                deferred.reject(errorMessage);
            });
        return deferred.promise;
    };

}])