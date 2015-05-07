appVendor.service("AccountService", function ($q, $auth) {
    var self = this;

    self.updateProfile = function (vendorData) {
        var deferred = $q.defer();
        $auth.updateAccount(vendorData)
            .then(function (response) {
                deferred.resolve(response)
            })
            .catch(function (response) {
                deferred.reject(response)
            });
        return deferred.promise;
    }
})