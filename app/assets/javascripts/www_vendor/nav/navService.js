appVendor.service('NavService', ['$http', 'CommonHttpRoutes', '$q',
    function($http, CommonHttpRoutes, $q) {
    this.fetchS3Policy = function() {
        var deferred = $q.defer();
        $http.get(CommonHttpRoutes.fetchS3Policy)
            .then(function(response) {
                deferred.resolve(response.data.data);
            })
            .catch(function(response) {
                deferred.reject(response.data.errors.full_messages.join("\n"));
            });
        return deferred.promise;
    };
}]);