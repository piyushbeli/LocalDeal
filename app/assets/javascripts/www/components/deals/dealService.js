appUser.service("DealService", function($http, $q, HttpRoutes, Review) {
    var self = this;

   self.submitReview = function(deal, review) {
       var deferred = $q.defer(),
           url = HttpRoutes.dealReviews.format({deal_id: deal.id});
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

    self.loadMoreReviews = function(deal, pageNo) {
        var deferred = $q.defer(),
            url = HttpRoutes.dealReviews.format({deal_id: deal.id}) + "?perPage=10&page=" + pageNo;
        $http.get(url)
            .then(function(response) {
                deferred.resolve(Review.build(response.data));
            })
        return deferred.promise;
    }
})