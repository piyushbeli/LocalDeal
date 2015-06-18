appUser.directive("dealSummary", function () {
    return {
        templateUrl: 'user/deal/dealSummary.html',
        restrict: 'A'
    }
})
    .directive("outletReviews", function () {
        return {
            templateUrl: 'user/outlet/outletReviews.html',
            restrict: 'A'
        }
    })
    .directive("dealOffers", function () {
        return {
            templateUrl: 'user/deal/dealOffers.html',
            restrict: 'A'
        }
    })