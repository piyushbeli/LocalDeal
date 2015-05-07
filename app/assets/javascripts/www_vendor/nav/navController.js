appVendor.controller("NavController", function ($scope, $auth, $rootScope, $modal, $state, $location) {

    $rootScope.$on('auth:logout-success', function (e) {
        $rootScope.vendor = null;
        $state.go('login');
    });
    $rootScope.$on('auth:invalid', function (e) {
        $rootScope.vendor = null;
        $state.go('login');
    });
    $rootScope.$on('auth:validation-success', function (e) {
        $rootScope.vendor = e.currentScope.user;
    });
    $rootScope.isLoggedIn = function () {
        return $auth.userIsAuthenticated();
    };

    $scope.doLogout = function () {
        $auth.signOut()
            .then(function (response) {

            })
            .catch(function (response) {

            })
    };

})