appUser.controller("DealDetailController", function($scope, $rootScope, $state, DealService, deal, $window, DealService) {
    if (deal) {
        $window.document.title = $window.document.title + deal.title;
    }
    $scope.deal = deal;
    $scope.review = {}; //If a user submit a review
    $scope.pageNo = 1; //Starting it from 1 because we already loaded first 10 reviews along with deal detail
    $scope.noMoreReviews = deal.reviewCount == 0;

    $scope.submitReview = function() {
        DealService.submitReview($scope.deal, $scope.review)
            .then(function(review) {
                alert("successfully submitted the review");
                $scope.deal.reviews.push(review);
                $scope.review = {};
            })
            .catch(function(errorMessage) {
                alert(errorMessage);
            })
    };

    $scope.loadMoreReviews = function() {
        DealService.loadMoreReviews($scope.deal, ++$scope.pageNo)
            .then(function(reviews) {
                if (!reviews.notEmpty()) {
                    $scope.noMoreReviews = true;
                    return;
                }
                $scope.deal.reviews = $scope.deal.reviews.concat(reviews);
            })
            .catch(function() {

            })
    }
})