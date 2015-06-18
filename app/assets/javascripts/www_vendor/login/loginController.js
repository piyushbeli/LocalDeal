appVendor.controller("LoginController", ['$scope', '$rootScope', '$state', 'Constants', 'LoginService', '$auth',
    function ($scope, $rootScope, $state, Constants, LoginService, $auth) {
    $scope.showLoginForm = true;
    $scope.vendor = {};
    $scope.isRegistrationSuccessful = false;

    if ($auth.userIsAuthenticated()) {
        $state.go(Constants.landingState);
    }

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
        $rootScope.vendor = e.currentScope.user;
        $state.go(Constants.landingState);
    });
    $rootScope.$on('auth:logout-success', function (e) {
        $rootScope.vendor = null
        $state.go('login');
    });

}])