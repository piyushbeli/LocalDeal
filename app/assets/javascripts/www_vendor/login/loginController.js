appVendor.controller("LoginController", ['$scope', '$rootScope', '$state', 'Constants', 'LoginService', '$auth', 'VerifyMeService', 'States',
    function ($scope, $rootScope, $state, Constants, LoginService, $auth, VerifyMeService, States) {
        $scope.showLoginForm = true;
        $scope.vendor = {};
        $scope.isRegistrationSuccessful = false;

        if ($auth.userIsAuthenticated()) {
            $state.go(Constants.landingState);
        }

        $scope.doLogin = function () {
            if ($scope.signInForm.$invalid) {
                return;
            }
            LoginService.doLogin($scope.vendor)
                .then(function () {

                })
                .catch(function (errorMessage) {
                    alert(errorMessage);
                })
        };

        $scope.doRegister = function () {
            if ($scope.signUpForm.$invalid) {
                return;
            }
            LoginService.doRegister($scope.vendor)
                .then(function (response) {
                    $scope.isRegistrationSuccessful = true;
                    $state.go(States.verifyMe);
                })
                .catch(function (errorMessage) {
                    alert(errorMessage);
                })
        };

        $scope.skipVerification = function() {
            $state.go(Constants.landingState);
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