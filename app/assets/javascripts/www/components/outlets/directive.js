appUser
    .directive("searchCriteria", function () {
        return {
            templateUrl: 'user/outlet/searchCriteria.html',
            restrict: 'A'
        }
    })
    .directive("outletList", function () {
        return {
            templateUrl: 'user/outlet/outletList.html',
            restrict: 'A'
        }
    })