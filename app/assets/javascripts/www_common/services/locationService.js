appCommon.service("LocationService", ['$q', function($q) {
    var self = this;

    self.getCurrentLocation = function() {
        var deferred = $q.defer();
        navigator.geolocation.getCurrentPosition(function (position) {
            deferred.resolve([position.coords.latitude, position.coords.longitude]);
        });
        return deferred.promise;
    };

}])