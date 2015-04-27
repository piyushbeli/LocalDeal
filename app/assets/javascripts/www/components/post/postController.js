app.controller("PostController", function ($scope, $rootScope, PostService, $auth, LoginService) {
    //$scope.isLoggedIn = auth;
    $scope.posts = [];
    PostService.fetchPosts()
        .then(function(response) {
            $scope.posts = response;
        })

    $scope.createPost = function () {
        if (!$scope.title || $scope.title === '') {
            return;
        }
        PostService.createPost({
            title: $scope.title,
            link: $scope.link
        })
            .then(function (post) {
                $scope.posts.push(post);
            })
        $scope.title = '';
        $scope.link = '';
    };

    $scope.upVotePost = function (post) {
        if ($rootScope.isLoggedIn()) {
            PostService.upVotePost(post)
                .then(function (response) {
                    post = response;
                })
        } else {
            LoginService.openLoginDialog();
        }

    };
})
