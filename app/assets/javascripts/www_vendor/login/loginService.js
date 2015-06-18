appVendor.service("LoginService", ['$auth', '$q', function($auth, $q) {
    var self = this;

    self.doLogin = function(vendorData) {
        var deferred = $q.defer();
        $auth.submitLogin(vendorData)
            .then(function (response) {
                deferred.resolve(response.data);
            })
            .catch(function (response) {
                deferred.reject(response.errors.fullMessage);
            })
        return deferred.promise;
    };

    self.doRegister = function(vendorData) {
        var deferred = $q.defer();
        $auth.submitRegistration(vendorData)
            .then(function (response) {
                deferred.resolve(response.data);
            })
            .catch(function (response) {
                deferred.reject(response.data.errors.fullMessages);
            })
        return deferred.promise;
    }
}])