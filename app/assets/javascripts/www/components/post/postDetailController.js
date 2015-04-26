app.controller("PostDetailController", function ($scope, PostService, post) {
    $scope.post = post;
    $scope.newComment = "";

    $scope.postComment = function () {
        PostService.postComment($scope.post, $scope.newComment)
            .then(function () {

            })
    };
    
    $scope.updatePost = function () {
        PostService.updatePost($scope.post)
            .then(function(response) {

            })
    };

})