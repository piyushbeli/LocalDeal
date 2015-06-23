appUser.service("AccountService", ['$auth', '$http', '$q', 'HttpRoutes', 'User',  function ($auth, $http, $q, HttpRoutes, User) {
    var self = this;

    self.updateProfile = function (user) {
        var deferred = $q.defer(),
            url = HttpRoutes.profile,
            postData = {
                email: user.email,
                mobile: user.mobile
            };
        $auth.updateAccount(postData)
            .then(function (response) {
                deferred.resolve(response)
            })
            .catch(function (response) {
                var errorMessage = Object.keys(response.data.errors).map(function (key) {
                    return key.toUpperCase() + ": " + response.data.errors[key].toString();
                })
                deferred.reject(errorMessage)
            });
        return deferred.promise;
    };

    self.fetchUserProfile = function () {
        var deferred = $q.defer();
        $auth.validateUser()
            .then(function (user) {
                deferred.resolve(User.build(user))
            })
            .catch(function () {
                deferred.reject("Error occurred while fetching user profile");
            })
        return deferred.promise;
    };

    self.updateFavoriteCategories = function(categories) {
        var deferred = $q.defer(),
            category_ids = categories.map(function (item) {
                return item.id;
            }),
            url = HttpRoutes.favoriteCategories.format();

        $http.post(url, {category_ids: category_ids})
            .then(function() {

            })
            .catch(function() {

            })
        return deferred.promise;
    };
}])