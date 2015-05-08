appVendor.service("AccountService", function ($q, $auth, $http, HttpRoutes, Outlet) {
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
    };

    self.createOutlet = function(outlet) {
        var deferred = $q.defer();
        $http.post(HttpRoutes.outlet, outlet)
            .then(function(response) {
                deferred.resolve();
            })
            .catch(function(response) {
                var errorMessage  = (response.data.errors && response.data.errors.join('\n')) || "Error occurred while creating outlet";
                deferred.reject(errorMessage);
            })
        return deferred.promise;

    };

    self.newOutlet = function() {

    }
})