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

}])