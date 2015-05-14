appVendor.controller("NavController", function ($scope, $auth, $rootScope, $modal, $state, $location, Vendor) {

    $rootScope.$on('auth:logout-success', function (e) {
        $rootScope.vendor = null;
        $state.go('login');
    });
    $rootScope.$on('auth:validation-error', function (e) {
        $rootScope.vendor = null;
        $state.go('login');
    });
    $rootScope.$on('auth:invalid', function (e) {
        $rootScope.vendor = null;
        $state.go('login');
    });
    $rootScope.$on('auth:validation-success', function (e) {
        $rootScope.vendor = Vendor.build(e.currentScope.user);
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