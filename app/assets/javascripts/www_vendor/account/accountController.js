appVendor.controller("AccountController", function ($scope, $rootScope, AccountService, $modal) {
    $scope.errorMessage = null;

    $scope.updateProfile = function () {
        AccountService.updateProfile($rootScope.vendor)
            .then(function (response) {

            })
            .catch(function (errorMessage) {
                $scope.errorMessage = errorMessage;
            })
    };
})

appVendor.controller('OutletModalController', function ($scope, $rootScope, AccountService) {
    $scope.shouldUseCurrentLocation = false;
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

    $scope.googlePlaceAutoCompleteOptions = {
        types: '(cities)',
        country: 'in'
    };

    $scope.userCurrentLocation = function() {
        if (!$scope.shouldUseCurrentLocation) {
            $scope.outlet.latitude = '';
            $scope.outlet.longitude = '';
            return;
        }
        navigator.geolocation.getCurrentPosition(function (position) {
            $scope.outlet.latitude = position.coords.latitude;
            $scope.outlet.longitude = position.coords.longitude;
        });
    }

});