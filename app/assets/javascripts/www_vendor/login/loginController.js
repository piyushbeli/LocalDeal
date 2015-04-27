appVendor.controller("LoginController", function($scope, $rootScope, $state, Constants, LoginService) {
    $scope.showLoginForm = true;
    $scope.vendor = {};
    $scope.isRegistrationSuccessful = false;

    $scope.doLogin = function() {
        LoginService.doLogin($scope.vendor)
            .then(function() {

            })
            .catch(function(erros) {

            })
    };

    $scope.doRegister = function() {
        LoginService.doRegister($scope.vendor)
            .then(function(response) {
                $scope.isRegistrationSuccessful = true;
            })
            .catch(function(errors) {
                alert(errors.join('\n'));
            })
    };

    //Register for events
    $rootScope.$on('auth:login-success', function (e) {
        $rootScope.user = e.currentScope.user;
        $state.go(Constants.landingState);
    });
    $rootScope.$on('auth:logout-success', function (e) {
        $rootScope.user = null
        $state.go('login');
    });

})