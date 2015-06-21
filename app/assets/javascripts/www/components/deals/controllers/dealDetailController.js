appUser.controller("DealDetailController", ['$scope', 'DealService', 'deal', '$window', 'DealService',
    function ($scope, DealService, deal, $window, DealService) {
        if (deal) {
            $window.document.title = deal.title + " | " + $window.document.title;
        }
        $scope.deal = deal;

        $scope.buyOffer = function (offer) {
            DealService.buyOffer(offer)
                .then(function (orderNo) {
                    alert("Congratulation, you have successfully bought this offer, please go to order page for more details");
                })
                .catch(function (errorMessage) {
                    alert(errorMessage);
                })
        };

        //End
    }])