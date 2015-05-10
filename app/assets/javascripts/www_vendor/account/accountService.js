appVendor.service("AccountService", function ($q, $auth, $http, HttpRoutes, Outlet, Utils) {
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

    self.saveOutlet = function(outlet) {
        var deferred = $q.defer();
        outlet.city_id = outlet.placeDetail && outlet.placeDetail.place_id;
        outlet.latitude = Utils.formatDecimal(outlet.latitude, 6);
        outlet.longitude = Utils.formatDecimal(outlet.longitude, 6);
        var request = {
            method: outlet.id ? 'PUT' : 'POST',
            url: outlet.id ? HttpRoutes.outlet + "/" + outlet.id : HttpRoutes.outlet ,
            data: outlet
        };
        $http(request)
            .then(function(response) {
                deferred.resolve(Outlet.build(response.data));
            })
            .catch(function(response) {
                var errorMessage  = (response.data.errors && response.data.errors.join('\n')) || "Error occurred while creating outlet";
                deferred.reject(errorMessage);
            })
        return deferred.promise;

    };

    self.newOutlet = function() {
        return Outlet.build();
    }
})