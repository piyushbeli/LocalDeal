appUser.controller("NavController", function ($scope, $auth, $rootScope, $modal, $state, $location) {
    //Lets fetch the current location and save in rootScope
    navigator.geolocation.getCurrentPosition(function (position) {
        $rootScope.currentLocation = [position.coords.latitude, position.coords.longitude];
    });


    $rootScope.$on('auth:login-success', function (e) {
        $rootScope.user = e.currentScope.user;
        $rootScope.isLoggedIn = true;
        //window.location.reload();
        if ($scope.loginModal) {
            $scope.loginModal.dismiss('cancel');
        }
    });
    $rootScope.$on('auth:validation-success', function (e) {
        $rootScope.user = e.currentScope.user;
    });
    $rootScope.$on('auth:logout-success', function (e) {
        $rootScope.user = null
    });
    $rootScope.$on('auth:invalid', function (e) {
        $rootScope.user = user;
    });
    $rootScope.$on('auth:validation-error', function (e) {
        $rootScope.user = null;
    });

    $rootScope.isLoggedIn = function() {
        return $auth.userIsAuthenticated();
    };

    $scope.openSignInModal = function () {
        $scope.loginModal = $modal.open({
            templateUrl: 'user/nav/login.html',
            controller: 'LoginController'
        });
    };

    $scope.doLogout = function () {
        $auth.signOut()
            .then(function (response) {

            })
            .catch(function (response) {

            })
    };

})