appUser.controller("DealDetailController", ['$scope', '$rootScope', '$state', 'DealService', 'deal', 'outlet', '$window', 'DealService',
    function($scope, $rootScope, $state, DealService, deal, outlet, $window, DealService) {
    if (deal) {
        $window.document.title = $window.document.title + deal.title;
    }

    $scope.buyOffer = function(offer) {
        DealService.buyOffer(offer, outlet)
            .then(function(orderNo) {
                alert("Congratulation, you have successfully bought this offer, please go to order page for more details");
            })
            .catch(function(errorMessage) {
                alert(errorMessage);
            })
    };

    //End
}])