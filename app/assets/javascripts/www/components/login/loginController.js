appUser.controller("LoginController", ['$scope', '$rootScope', '$modalInstance', '$auth', '$state', '$log',
    function ($scope, $rootScope, $modalInstance, $auth, $state, $log) {
        $scope.showLoginForm = true;
        $scope.user = {};

        /*
        We will sent this opts in the authenticate method because ng-token-auth 0.1.28 is not working, and setting this config is not working with 0.1.24 version.
        This is a workaround which is working for now.
        */
        var opts = {
            params: {
                omniauth_window_type: 'newWindow'
            }
        };

        $scope.close = function () {
            $modalInstance.dismiss('cancel');
        };

        $scope.tryLogin = function () {
            $scope.showLoginForm = true;
            $scope.showSignUpForm = false;
        };
        $scope.trySignUp = function () {
            $scope.showLoginForm = false;
            $scope.showSignUpForm = true;
        };

        $scope.doLogin = function () {
            var postData = {
                email: $scope.user.userName,
                password: $scope.user.password
            }
            $auth.submitLogin(postData)
                .then(function (response) {
                    $state.reload();
                })
                .catch(function (response) {
                    alert(response.errors.join("\n"));
                })
        };

        $scope.doRegister = function () {
            var postData = {
                email: $scope.user.userName,
                password: $scope.user.password,
                password_confirmation: $scope.user.confirmPassword,
                name: $scope.user.name
            }
            $auth.submitRegistration(postData)
                .then(function (response) {
                    $scope.registrationSuccessful = true;
                })
                .catch(function (response) {
                    alert(response.data.errors.full_messages.join(','))
                })
        };

        $scope.loginWithFB = function () {
            $auth.authenticate('facebook', opts)
                .then(function (response) {
                    $log.log(JSON.stringify(response));
                    window.location.reload();
                })
                .catch(function (response) {
                    $log.log(JSON.stringify(response))
                });
        };

        $scope.loginWithGoogle = function () {
            $auth.authenticate('google', opts)
                .then(function (response) {
                    $log.log(JSON.stringify(response));
                    window.location.reload();
                })
                .catch(function (response) {
                    $log.log(JSON.stringify(response))
                })
        }

    }])