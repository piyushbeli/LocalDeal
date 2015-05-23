appUser.controller("OutletDetailController", function($scope, $rootScope, outlet, $window) {
    $window.document.title = $window.document.title + " - Outlets - " + outlet.name;
    $scope.outlet = outlet;
})