appUser.controller("DealDetailController", function($scope, $rootScope, $state, DealService, deal, $window, DealService) {
    if (deal) {
        $window.document.title = $window.document.title + deal.title;
    }
    $scope.deal = deal;
    $scope.review = {}; //If a user submit a review
    $scope.comment = {}; //For comment on a review
    $scope.pageNo = 1; //Starting it from 1 because we already loaded first 10 reviews along with deal detail
    $scope.noMoreReviews = deal.reviewCount == 0;

    $scope.submitReview = function() {
        DealService.submitReview($scope.deal, $scope.review)
            .then(function(review) {
                alert("successfully submitted the review");
                //Reviews are already sorted in createAt, so instead of pushing add at the front
                $scope.deal.reviews.unshift(review);
                deal.reviewCount++;
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
    };

    //Note that these review and comment parameters are coming as an argument from template, these are different than
    //$scope.review and $scope.comment
    $scope.postComment = function(review) {
        DealService.postComment(review, review.newComment)
            .then(function(comment) {
                review.comments.push(comment);
                review.newComment = null;
            })
            .catch(function(errorMessage) {
                alert(errorMessage);
            })
    }
})