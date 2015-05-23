appUser.controller("DealDetailController", function($scope, $rootScope, $state, DealService, deal, $window) {
    if (deal) {
        $window.document.title = $window.document.title + " - Deals - " + deal.title;
    }
    $scope.deal = deal;
})