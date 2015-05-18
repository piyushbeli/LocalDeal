appVendor.controller("AccountController", function ($scope, $rootScope, AccountService) {
    $scope.errorMessage = null;

    $scope.updateProfile = function () {
        AccountService.updateProfile($rootScope.vendor)
            .then(function (response) {

            })
            .catch(function (errorMessage) {
                $scope.errorMessage = errorMessage;
            })
    };
});