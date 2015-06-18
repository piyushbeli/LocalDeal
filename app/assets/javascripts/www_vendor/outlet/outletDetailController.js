appVendor.controller('OutletDetailController', ['$scope', '$rootScope', 'OutletService', '$log', 'uiGmapGoogleMapApi',
    'uiGmapIsReady', 'Utils', 'LocationService', 'outlet', 'States', 'Geocoder', '$state',
    function ($scope, $rootScope, OutletService, $log, uiGmapGoogleMapApi, uiGmapIsReady, Utils, LocationService,
              outlet, States, Geocoder, $state) {
        var self = this;
        $scope.outlet = outlet;
        $scope.shouldUseCurrentLocation = false;
        $scope.currentLocation = {};

        //Lets fetch the current location
        LocationService.getCurrentLocation()
            .then(function (location) {
                $scope.currentLocation.latitude = location[0];
                $scope.currentLocation.longitude = location[1];
                //Set the center of the map to current location initially if outle's latitude and longitude is not already set.
                if ($scope.outlet && $scope.outlet.latitude && $scope.outlet.longitude) {
                    self.setMapOnThisCenter($scope.outlet.latitude, $scope.outlet.longitude, 18);
                } else {
                    self.setMapOnThisCenter(location[0], location[1], 15);
                }
            })

        //Set options and initial setting for map
        $scope.map = {center: {latitude: 45, longitude: -73}, zoom: 10};
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

        $scope.pinOutlet = function () {
            var address = $scope.outlet.name + " " + $scope.outlet.street;
            Geocoder.geocodeAddress(address)
                .then(function (address) {
                    console.log(JSON.stringify(address));
                    $scope.outlet.latitude = address.lat;
                    $scope.outlet.longitude = address.lng;
                    self.setMapOnThisCenter($scope.outlet.latitude, $scope.outlet.longitude, 18);
                })
                .catch(function (error) {
                    console.log(JSON.stringify(error));
                    alert(error);
                });
        };

        $scope.save = function () {
            OutletService.saveOutlet($scope.outlet)
                .then(function (response) {
                    if ($scope.outlet.id) {
                        $scope.outlet = response;
                    } else {
                        $rootScope.vendor.outlets.push(response);
                    }
                    $state.go(States.outlets);
                })
                .catch(function (errorMessage) {
                    alert(errorMessage);
                });
        };

        $scope.cancel = function() {
            $state.go(States.outlets);
        };

        $scope.googlePlaceAutoCompleteOptionsCity = Utils.googlePlaceAutoCompleteOptionsCity();
        $scope.googlePlaceAutoCompleteOptionsStreet = Utils.googlePlaceAutoCompleteOptionsStreet(/*$scope.outlet ? $scope.outlet.getStreetBoundary() : ""*/);

        $scope.userCurrentLocation = function () {
            if (!$scope.shouldUseCurrentLocation) {
                $scope.outlet.latitude = '';
                $scope.outlet.longitude = '';
            } else {
                $scope.outlet.latitude = $scope.currentLocation.latitude;
                $scope.outlet.longitude = $scope.currentLocation.longitude;
                self.setMapOnThisCenter($scope.outlet.latitude, $scope.outlet.longitude, 18);
            }
        };

        self.setMapOnThisCenter = function (lat, lng, zoom) {
            $scope.map.center.latitude = lat;
            $scope.map.center.longitude = lng;
            $scope.marker.coords.latitude = lat;
            $scope.marker.coords.longitude = lng;
            $scope.map.zoom = zoom || 15;
        }

        $scope.$watch('outlet.cityDetail', function (newVal, oldVal) {
            if (newVal && newVal.geometry) {
                self.setMapOnThisCenter(newVal.geometry.location.lat(), newVal.geometry.location.lng(), 15);
                $scope.streetDetail = null;
                $scope.outlet.latitude = newVal.geometry.location.lat();
                $scope.outlet.longitude = newVal.geometry.location.lng();
            }
        });
        $scope.$watch('outlet.city', function (newVal, oldVal) {
            if (newVal == null || newVal.trim() == "") {
                $scope.cityDetail = null;
            }
        });

        $scope.$watch('outlet.streetDetail', function (newVal, oldVal) {
            if (newVal && newVal.geometry) {
                self.setMapOnThisCenter(newVal.geometry.location.lat(), newVal.geometry.location.lng(), 17);
                $scope.outlet.latitude = newVal.geometry.location.lat();
                $scope.outlet.longitude = newVal.geometry.location.lng();
            }
        });
        $scope.$watch('outlet.street', function (newVal, oldVal) {
            if (newVal == null || newVal.trim() == "") {
                $scope.streetDetail = null;
            }
        });

        $scope.$watch('outlet', function (newVal, oldVal) {
            if (newVal && !newVal.isNew()) {
                self.setMapOnThisCenter(newVal.latitude, newVal.longitude, 15);
            }
        })


    }]);