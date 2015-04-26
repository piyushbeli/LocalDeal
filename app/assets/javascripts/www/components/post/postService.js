app.service("PostService", function ($q, $http) {
    var self = this;

    self.fetchPosts = function () {
        var deferred = $q.defer();

        $http.get('/posts.json')
            .then(function (response) {
                deferred.resolve(response.data);
            })
            .catch(function (error) {
                deferred.reject(error);
            });
        return deferred.promise;
    };

    self.createPost = function (post) {
        var deferred = $q.defer();

        $http.post('/posts.json', post)
            .then(function (response) {
                deferred.resolve(response.data);
            })

        return deferred.promise;
    };

    self.upVotePost = function (post) {
        var deferred = $q.defer();
        $http.put('/posts/' + post.id + '/upvote.json')
            .then(function (response) {
                post.upvotes++;
                deferred.resolve(post);
            })
        return deferred.promise;
    };

    self.fetchPost = function(id) {
        var deferred = $q.defer();
        $http.get('posts/' + id + '.json')
            .then(function (response) {
                deferred.resolve(response.data)
            })
        return deferred.promise;
    };

    self.postComment = function (post, comment) {
        var deferred = $q.defer();
        var postData = {
            body: comment
        }
        $http.post('/posts/' + post.id + '/comments.json', postData)
            .then(function (response) {
                post.comments.push(response.data);
            })
        return deferred.promise;
    };

    self.updatePost = function(post) {
        var deferred = $q.defer();
        $http.put('/posts/' + post.id + '.json', post)
            .then(function (response) {
                post = response.data
            })
            .catch(function(response) {
                console.log(JSON.stringify(response))
            })
        return deferred.promise;
    };

    return self;
})