app.controller("NavController", function ($scope, $auth, $rootScope, $modal, $state, $location) {
    $rootScope.$on('auth:login-success', function (e) {
        $rootScope.user = e.currentScope.user;
        $rootScope.isLoggedIn = true;
        //window.location.reload();
        if ($scope.registerModal) {
            $scope.registerModal.dismiss('cancel');
        }
    });
    $rootScope.$on('auth:logout-success', function (e) {
        $rootScope.user = null
    });
    $rootScope.$on('auth:invalid', function (e) {
        $rootScope.user = e.currentScope.user;
    });
    $rootScope.$on('auth:validation-success', function (e) {
        $rootScope.user = e.currentScope.user;
    });
    $rootScope.isLoggedIn = function() {
        return $auth.userIsAuthenticated();
    };

    $scope.openSignInModal = function () {
        $scope.registerModal = $modal.open({
            templateUrl: 'nav/login.html',
            controller: 'LoginController',
            //size: size,
            resolve: {
                items: function () {
                    return $scope.items;
                }
            }
        });
    }

    $scope.doLogout = function () {
        $auth.signOut()
            .then(function (response) {

            })
            .catch(function (response) {

            })
    };

})