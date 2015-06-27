appUser.controller("OutletDetailController", ['$scope', '$rootScope', 'outlet', '$window', 'OutletService',
    'ReviewService', 'CommonConstants',
    function ($scope, $rootScope, outlet, $window, OutletService, ReviewService, CommonConstants) {

        $window.document.title =  outlet.name + " " + outlet.street + " | " + CommonConstants.appName;

        $scope.outlet = outlet;
        $scope.showReportAbuseComment = false;

        $scope.pageNo = 1; //Starting it from 1 because we already loaded first 10 reviews along with deal detail

        $scope.reportSpam = function (reason) {
            OutletService.reportSpam(outlet, reason)
                .then(function () {
                    $scope.showReportAbuseComment = false;
                    $scope.outlet.vendor.spammed = true;
                })
                .catch(function (errorMessage) {
                    alert(errorMessage);
                })
        };

        $scope.unSpam = function () {
            OutletService.unSpam($scope.outlet)
                .then(function () {
                    $scope.outlet.vendor.spammed = false;
                })
                .catch(function (errorMessage) {
                    alert(errorMessage);
                })
        };

        $scope.toggleFavorite = function (outlet) {
            if (!$rootScope.isLoggedIn()) {
                LoginService.openLoginDialog();
                return;
            }
            OutletService.toggleFavorite(outlet)
                .then(function (response) {
                    $rootScope.data.favoriteOutletsCount++;
                    outlet.markedAsFavorite = !outlet.markedAsFavorite;
                })
                .catch(function (errorMessage) {
                    alert(errorMessage);
                })
        };

        $scope.hoveringOver = function(val) {
            $scope.overStar = val;
            $scope.value = val/2; //Because we are using 1-5 scale but on UI we would show 10 stars so that half star can work
        };

        $scope.$watch('outlet.userRating', function(newVal, oldVal) {
            if (newVal && newVal != oldVal) {
                //Do half before sending to service, because we are showing 10 stars but scale is 1 to 5
                OutletService.updateUserRating($scope.outlet, newVal/2)
                    .then(function () {

                    })
                    .catch(function () {
                        $scope.outlet.userRating = oldVal;
                    })
            }
        });

    }])