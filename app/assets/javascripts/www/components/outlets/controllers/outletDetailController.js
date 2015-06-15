appUser.controller("OutletDetailController", ['$scope', '$rootScope', 'outlet', '$window', 'OutletService', 'ReviewService',
    function ($scope, $rootScope, outlet, $window, OutletService, ReviewService) {

        $window.document.title = $window.document.title + " - Outlets - " + outlet.name;
        $scope.outlet = outlet;
        $scope.showReportAbuseComment = false;

        $scope.review = {}; //If a user submit a review
        $scope.comment = {}; //For comment on a review
        $scope.pageNo = 1; //Starting it from 1 because we already loaded first 10 reviews along with deal detail
        $scope.noMoreReviews = outlet.reviewCount == 0;

        $scope.submitReview = function () {
            ReviewService.submitReview($scope.outlet, $scope.review)
                .then(function (review) {
                    alert("successfully submitted the review");
                    //Reviews are already sorted in createAt, so instead of pushing add at the front
                    $scope.outlet.reviews.unshift(review);
                    $scope.outlet.reviewCount++;
                    $scope.review = {};
                })
                .catch(function (errorMessage) {
                    alert(errorMessage);
                })
        };

        $scope.loadMoreReviews = function () {
            ReviewService.loadMoreReviews($scope.outlet, ++$scope.pageNo)
                .then(function (reviews) {
                    if (!reviews.notEmpty()) {
                        $scope.noMoreReviews = true;
                        return;
                    }
                    $scope.outlet.reviews = $scope.outlet.reviews.concat(reviews);
                })
                .catch(function () {

                })
        };

        //Note that these review and comment parameters are coming as an argument from template, these are different than
        //$scope.review and $scope.comment
        $scope.postComment = function (review) {
            ReviewService.postComment(review, review.newComment)
                .then(function (comment) {
                    review.comments.push(comment);
                    review.newComment = null;
                })
                .catch(function (errorMessage) {
                    alert(errorMessage);
                })
        };

        $scope.reportSpam = function (reason) {
            OutletService.reportSpam(outlet, reason)
                .then(function () {
                    $scope.showReportAbuseComment = false;
                    $scope.outlet.vendor.spammed = true;
                })
                .catch(function (errorMessage) {
                    alert(errorMessage);
                })
        };

        $scope.unSpam = function () {
            OutletService.unSpam($scope.outlet)
                .then(function () {
                    $scope.outlet.vendor.spammed = false;
                })
                .catch(function (errorMessage) {
                    alert(errorMessage);
                })
        };

        $scope.toggleFavorite = function (outlet) {
            if (!$rootScope.isLoggedIn()) {
                LoginService.openLoginDialog();
                return;
            }
            OutletService.toggleFavorite(outlet)
                .then(function (response) {
                    $rootScope.data.favoriteOutletsCount++;
                    outlet.markedAsFavorite = !outlet.markedAsFavorite;
                })
                .catch(function (errorMessage) {
                    alert(errorMessage);
                })
        };

    }])