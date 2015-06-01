appUser.service("DealService", ['$http', '$q', 'HttpRoutes', 'Review', function($http, $q, HttpRoutes, Review) {
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