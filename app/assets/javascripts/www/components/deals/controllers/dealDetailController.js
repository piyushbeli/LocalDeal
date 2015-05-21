appUser.controller("DealDetailController", function($scope, $rootScope, $state, DealService, deal, $window) {
    $window.document.title = $window.document.title + " - Deals - " + deal.title;
})