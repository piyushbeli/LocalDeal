appUser.directive("dealSummary", function () {
    return {
        templateUrl: 'user/deal/dealSummary.html',
        restrict: 'A'
    }
})
    .directive("dealReviews", function () {
        return {
            templateUrl: 'user/deal/dealReviews.html',
            restrict: 'A'
        }
    })
    .directive("dealOffers", function () {
        return {
            templateUrl: 'user/deal/dealOffers.html',
            restrict: 'A'
        }
    })