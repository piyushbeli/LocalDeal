appCommon.service("LocationService", ['$q', function ($q) {
    var self = this;
    self.isLocationServiceOn = null;

    self.getCurrentLocation = function () {
        var deferred = $q.defer();
        navigator.geolocation.getCurrentPosition(function (position) {
                self.isLocationServiceOn = true;
                deferred.resolve([position.coords.latitude, position.coords.longitude]);
            },
            function (error) {
                //If geo location service is not enabled
                if( self.isLocationServiceOn != false) {
                    alert("Please turn on the location service by going Setting->Advance->Content Setting->Location->Manage Exception " +
                    "and then delete the block entry");
                    self.isLocationServiceOn = false;
                }
                deferred.resolve(null);
            });
        return deferred.promise;
    };

}])