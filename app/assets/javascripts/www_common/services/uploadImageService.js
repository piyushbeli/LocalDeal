appCommon.service('UploadImageService', ['$http', '$q', 'CommonHttpRoutes', 'Image', 'Menu', function ($http, $q, CommonHttpRoutes, Image, Menu) {

    this.uploadImage = function (url, outletId, offerId, commentsId) {
        if (!outletId) {
            return;
        }
        var deferred = $q.defer();
        var data = {
            url: url,
            outlet_id: outletId,
            offer_id: offerId,
            comment_id: commentsId
        };
        $http
            .post(CommonHttpRoutes.uploadImage.format({outlet_id: outletId}), data)
            .then(function (response) {
                deferred.resolve(Image.build(response.data));
            })
            .catch(function (response) {
                //As of now no action
                var errorMessage = response.message || response.data.errors.join("\n");
                deferred.reject(errorMessage);
            });
        return deferred.promise;
    };

    this.uploadMenu = function (url, outletId) {
        if (!outletId) {
            return;
        }
        var deferred = $q.defer();
        var data = {
            url: url
        };
        $http
            .post(CommonHttpRoutes.uploadMenu.format({outlet_id: outletId}), data)
            .then(function (response) {
                deferred.resolve(Menu.build(response.data));
            })
            .catch(function (response) {
                //As of now no action
                var errorMessage = response.message || response.data.errors.join("\n");
                deferred.reject(errorMessage);
            });
        return deferred.promise;
    };
}]);