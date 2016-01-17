appVendor.controller('VerifyMeController', ['$scope', 'VerifyMeService', '$state',
    function($scope, VerifyMeService, $state) {
    $scope.verifyMe = function() {
        VerifyMeService.verifyMe($scope.otp)
            .then(function() {
                $state.go(Constants.landingState);
            })
            .catch(function(errorMessage) {
                alert(errorMessage)
            })
    };

    $scope.sendOTP = function() {
        VerifyMeService.sendOTP($scope.user.mobile)
            .then(function() {

            })
            .catch(function(errorMessage) {
                alert(errorMessage)
            })
    };
}]);