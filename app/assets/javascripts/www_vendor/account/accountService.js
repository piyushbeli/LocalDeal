appVendor.service("AccountService", ['$q', '$auth', '$http', 'HttpRoutes', 'Outlet', 'Utils', function ($q, $auth, $http, HttpRoutes, Outlet, Utils) {
    var self = this;

    self.updateProfile = function (vendor) {
        var deferred = $q.defer(),
            postData = {
                name: vendor.name,
                mobile: vendor.mobile,
                category_id: vendor.category && vendor.category.id,
                subcategory_ids: vendor.subcategories.map(function(item) {
                    return item.id
                }),
                website: vendor.website
            }
        $auth.updateAccount(postData)
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
        outlet.latitude = Utils.formatDecimal(outlet.latitude, 6);
        outlet.longitude = Utils.formatDecimal(outlet.longitude, 6);
        var request = {
            method: outlet.id ? 'PUT' : 'POST',
            url: outlet.id ? HttpRoutes.outlet + "/" + outlet.id : HttpRoutes.outlet ,
            data: {
                name: outlet.name,
                city: outlet.city,
                city_id: outlet.cityDetail && outlet.cityDetail.place_id,
                street: outlet.street,
                street_id: outlet.streetDetail && outlet.streetDetail.place_id,
                latitude: outlet.latitude,
                longitude: outlet.longitude,
                mobile: outlet.mobile,
                email: outlet.email,
                contact_no: outlet.contactNo,
                address: outlet.address
            }
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
}])