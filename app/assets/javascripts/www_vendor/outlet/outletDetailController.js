appVendor.controller('OutletDetailController', ['$scope', '$rootScope', 'OutletService', '$log', 'uiGmapGoogleMapApi',
    'uiGmapIsReady', 'Utils', 'LocationService', 'outlet', 'States', 'Geocoder', '$state', '$timeout', 'AwsService', 'UploadImageService',
    function ($scope, $rootScope, OutletService, $log, uiGmapGoogleMapApi, uiGmapIsReady, Utils, LocationService,
              outlet, States, Geocoder, $state, $timeout, AwsService, UploadImageService) {
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
                    $timeout(function() {
                        self.setMapOnThisCenter($scope.outlet.latitude, $scope.outlet.longitude, 18);
                    }, 1500);
                } else {
                    $timeout(function() {
                        self.setMapOnThisCenter(location[0], location[1], 15);
                    }, 1500);
                }
            })

        //Set options and initial setting for map
        $scope.map = {
            center: {latitude: 40.1451, longitude: -99.6680},
            zoom: 4,
            events: {
                dragend: function (map, eventName, args) {
                    var lat = map.center.lat();
                    var lon = map.center.lng();
                    $scope.outlet.latitude = lat;
                    $scope.outlet.longitude = lon;
                }
            },
            options: {scrollwheel: false}
        };
        //End google map setting

        $scope.pinOutlet = function () {
            var address = $scope.outlet.name + ", " + $scope.outlet.street;
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
            if ($scope.outLetContactDetailForm.$invalid || $scope.outLetLocationDetailForm.$invalid) {
                return;
            }
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
            $scope.map.zoom = zoom;
        }

        $scope.$watch('outlet.cityDetail', function (newVal, oldVal) {
            if (newVal && newVal.geometry) {
                self.setMapOnThisCenter(newVal.geometry.location.lat(), newVal.geometry.location.lng(), 10);
                $scope.streetDetail = null;
                $scope.outlet.latitude = newVal.geometry.location.lat();
                $scope.outlet.longitude = newVal.geometry.location.lng();
                if ($scope.outlet.cityDetail.name) {
                    $scope.outlet.city = $scope.outlet.cityDetail.name;
                    $scope.outlet.cityDetail.formatted_address = $scope.outlet.cityDetail.name;
                }
                $scope.outlet.cityDetail.latitude = $scope.outlet.cityDetail.geometry.location.lat();
                $scope.outlet.cityDetail.longitude = $scope.outlet.cityDetail.geometry.location.lng();
            }
        });
        $scope.$watch('outlet.city', function (newVal, oldVal) {
            if (newVal == null || newVal.trim() == "") {
                $scope.cityDetail = null;
            } else if ($scope.outlet.cityDetail && $scope.outlet.cityDetail.name) {
                $scope.outlet.cityDetail.formatted_address = $scope.outlet.cityDetail.name;
            }
            createAddress()
        });

        $scope.$watch('outlet.streetDetail', function (newVal, oldVal) {
            if (newVal && newVal.geometry) {
                self.setMapOnThisCenter(newVal.geometry.location.lat(), newVal.geometry.location.lng(), 16);
                $scope.outlet.latitude = newVal.geometry.location.lat();
                $scope.outlet.longitude = newVal.geometry.location.lng();
                if ($scope.outlet.streetDetail.name) {
                    $scope.outlet.street = $scope.outlet.streetDetail.name;
                    $scope.outlet.streetDetail.formatted_address = $scope.outlet.streetDetail.name;
                }
                $scope.outlet.streetDetail.latitude = $scope.outlet.streetDetail.geometry.location.lat();
                $scope.outlet.streetDetail.longitude = $scope.outlet.streetDetail.geometry.location.lng();
                createAddress();
            }
        });
        $scope.$watch('outlet.street', function (newVal, oldVal) {
            if (newVal == null || newVal.trim() == "") {
                $scope.streetDetail = null;
            } else if ($scope.outlet.streetDetail && $scope.outlet.streetDetail.name) {
                    $scope.outlet.street = $scope.outlet.streetDetail.name;
            }
        });

        $scope.$watch('outlet', function (newVal, oldVal) {
            if (newVal && !newVal.isNew()) {
                //self.setMapOnThisCenter(newVal.latitude, newVal.longitude, 6);
            }
        });

        $scope.uploadFiles = function (files) {
            for (var i=0; i< files.length; i++) {
                $scope.uploadFile(files[i]);
            }
        };

        $scope.uploadFile = function(file) {
            var entity = {type: 'Outlet', id: $scope.outlet.id};
            var uploadedBy = {type: 'Vendor', id: $rootScope.vendor.id}
            AwsService
                .uploadImagesToS3(file, entity, uploadedBy, 'image')
                .then(function (url) {
                    console.log("Uploaded successfully on aws: " + JSON.stringify(url));
                    return UploadImageService.uploadImage(url, outlet.id);
                })
                .then(function(image) {
                    $timeout(function() {
                        $scope.outlet.images.push(image);
                    }, 500);
                })
                .catch(function (error) {
                    console.log("Error while uploading the file: " + error);
                });
        };

        $scope.uploadProfilePic = function(file) {

        };

        $scope.isLoadingImages = true;
        OutletService.fetchOutletImages($scope.outlet)
            .then(function (images) {
                $scope.outlet.images = images;
            })
            .catch(function (error) {

            })
            .finally(function () {
                $scope.isLoadingImages = false;
            })

        function createAddress() {
            if ($scope.outlet.address) {
                return;
            }
            var address = '';
            if ($scope.outlet.name) {
                address = address + $scope.outlet.name;
                if ($scope.outlet.street) {
                    address = address + ', ' + $scope.outlet.street;
                    if ($scope.outlet.city) {
                        address = address + ', ' + $scope.outlet.city;
                        $scope.outlet.address = address;
                    }
                }
            }

        }


    }]);