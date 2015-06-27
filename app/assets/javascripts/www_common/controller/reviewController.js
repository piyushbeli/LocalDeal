appCommon.controller("ReviewController", ['$scope', '$window', 'ReviewService', 'CommonConstants',
    function ($scope, $window, ReviewService, CommonConstants) {
        //$window.document.title =  $scope.outlet.name + " " + $scope.outlet.street + " - Reviews " + " | " + CommonConstants.appName;

        //$scope.outlet = outlet;
        $scope.review = {}; //If a user submit a review
        $scope.comment = {}; //For comment on a review
        $scope.showCommentBox = false;
        $scope.page = 1;
        $scope.itemsPerPage = CommonConstants.itemsPerPage;

        $scope.refreshItems = function () {
            ReviewService.refreshItems($scope.outlet, $scope.page)
                .then(function (response) {
                    $scope.totalItems = response.totalItems;
                    $scope.reviews = response.items;
                })
                .catch(function () {

                })
        };
        $scope.refreshItems();

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

    }])