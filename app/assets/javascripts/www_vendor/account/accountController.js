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

    $scope.addOutlet = function (outlet) {
        var modalInstance = $modal.open({
            templateUrl: 'vendor/outlet/outlet.html',
            controller: 'OutletModalController',
            resolve: {
                outlet: function () {
                    return outlet ? outlet : AccountService.newOutlet();
                }
            }
        });
    }
})

appVendor.controller('OutletModalController', function ($scope, $rootScope, $modalInstance, AccountService, outlet) {
    $scope.outlet = outlet;
    $scope.save = function () {
        AccountService.createOutlet($scope.outlet)
            .then(function(response) {
                $rootScope.vendor.outlets.push(response);
                $modalInstance.close();
            })
            .catch(function(errorMessage) {
                alert(errorMessage);
            });
    };

    $scope.close = function () {
        $modalInstance.dismiss('cancel');
    };

});