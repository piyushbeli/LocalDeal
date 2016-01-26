appVendor.controller("NavController", ['$scope', '$auth', '$rootScope', '$modal', '$state', '$location', '$window', 'Vendor',
    function ($scope, $auth, $rootScope, $modal, $state, $location, $window, Vendor) {

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
        $rootScope.$on('auth:session-expired', function (ev) {
            alert('Session has expired, please login again');
            $state.go('login');
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

        $scope.$back = function () {
            setTimeout(function () {
                $window.history.back();
            }, 100);
        };

        /*Toggle navigation on mobile*/
        $('.menuBtn').on('click', function(){
            $('#navigation').toggleClass('selected');
            $('#overlay').toggleClass('overlay');
            $('html').toggleClass('scroll-no');
        });

        $('#overlay').on('click', function(){
            $('#navigation').toggleClass('selected');
            $('#overlay').toggleClass('overlay');
            $('html').toggleClass('scroll-no');
        });

        $('.head-nav a').on('click', function() {
            $('#overlay').click();
        });

    }])