appVendor.controller('OutletController', function ($scope, $rootScope, AccountService, $log, uiGmapGoogleMapApi,
                                                   uiGmapIsReady, Utils) {
    var self = this;
    $scope.shouldUseCurrentLocation = false;
    $scope.currentLocation = {};

    //Lets fetch the current location
    navigator.geolocation.getCurrentPosition(function (position) {
        $scope.currentLocation.latitude = position.coords.latitude;
        $scope.currentLocation.longitude = position.coords.longitude;
        //Set the center of the map to current location initially if outle's latitude and longitude is not already set.
        if ($scope.outlet && $scope.outlet.latitude && $scope.outlet.longitude) {
            self.setMapOnThisCenter($scope.outlet.latitude, $scope.outlet.longitude);
        } else {
            self.setMapOnThisCenter(position.coords.latitude, position.coords.longitude);
        }
    });

    //Set options and initial setting for map
    $scope.map = { center: { latitude: 45, longitude: -73 }, zoom: 8 };
    $scope.options = {scrollwheel: true};
    $scope.marker = {
        id: 0,
        coords: {
            latitude: 45,
            longitude: -73
        },
        options: {draggable: true},
        events: {
            dragend: function (marker, eventName, args) {
                var lat = marker.getPosition().lat();
                var lon = marker.getPosition().lng();
                $scope.outlet.latitude = lat;
                $scope.outlet.longitude = lon;
            }
        }
    }
    //End google map setting

    $scope.addOutlet = function (outlet) {
        $scope.outlet =  AccountService.newOutlet();
    };

    $scope.save = function () {
        AccountService.saveOutlet($scope.outlet)
            .then(function(response) {
                if ($scope.outlet.id) {
                    $scope.outlet = response;
                } else {
                    $rootScope.vendor.outlets.push(response);
                }
                $scope.close();
            })
            .catch(function(errorMessage) {
                alert(errorMessage);
            });
    };

    $scope.selectOutlet = function(outlet) {
        $scope.outlet = outlet;
        $scope.shouldUseCurrentLocation = false;
    };

    $scope.close = function () {
        $scope.outlet = null;
    };

    $scope.googlePlaceAutoCompleteOptionsCity = Utils.googlePlaceAutoCompleteOptionsCity();
    $scope.googlePlaceAutoCompleteOptionsStreet =  Utils.googlePlaceAutoCompleteOptionsStreet( /*$scope.outlet ? $scope.outlet.getStreetBoundary() : ""*/);

    $scope.userCurrentLocation = function() {
        if (!$scope.shouldUseCurrentLocation) {
            $scope.outlet.latitude = '';
            $scope.outlet.longitude = '';
        } else {
            $scope.outlet.latitude = $scope.currentLocation.latitude;
            $scope.outlet.longitude = $scope.currentLocation.longitude;
            self.setMapOnThisCenter($scope.outlet.latitude, $scope.outlet.longitude,15);
        }
    };

    self.setMapOnThisCenter = function(lat, lng, zoom) {
        $scope.map.center.latitude = lat;
        $scope.map.center.longitude = lng;
        $scope.marker.coords.latitude = lat;
        $scope.marker.coords.longitude = lng;
        $scope.map.zoom = zoom || 15;
    }

    $scope.$watch('outlet.cityDetail', function(newVal, oldVal) {
        if (newVal && newVal.geometry) {
            self.setMapOnThisCenter(newVal.geometry.location.lat(), newVal.geometry.location.lng(), 15);
        }
    });
    $scope.$watch('outlet.city', function(newVal, oldVal) {
        if (newVal == null || newVal.trim() == "") {
            $scope.cityDetail = null;
        }
    });

    $scope.$watch('outlet.streetDetail', function(newVal, oldVal) {
        if (newVal && newVal.geometry) {
            self.setMapOnThisCenter(newVal.geometry.location.lat(), newVal.geometry.location.lng(), 17);
        }
    });
    $scope.$watch('outlet.street', function(newVal, oldVal) {
        if (newVal == null || newVal.trim() == "") {
            $scope.streetDetail = null;
        }
    });

    $scope.$watch('outlet', function(newVal, oldVal) {
        if (newVal && !newVal.isNew()) {
            self.setMapOnThisCenter(newVal.latitude, newVal.longitude, 17);
        }
    })


});