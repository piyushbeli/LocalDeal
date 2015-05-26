appUser.controller("OutletDetailController", function($scope, $rootScope, outlet, $window, OutletService) {
    $window.document.title = $window.document.title + " - Outlets - " + outlet.name;
    $scope.outlet = outlet;

    $scope.showReportAbuseComment = false;
    $scope.reportSpam = function(reason) {
        OutletService.reportAbuse(outlet, reason)
            .then(function() {
                $scope.showReportAbuseComment = false;
                $scope.outlet.vendor.spammed = true;
            })
            .catch(function(errorMessage) {
                alert(errorMessage);
            })
    };

    $scope.unSpam = function() {
        OutletService.unSpam($scope.outlet)
            .then(function() {
                $scope.outlet.vendor.spammed = false;
            })
            .catch(function(errorMessage) {
                alert(errorMessage);
            })
    };
})