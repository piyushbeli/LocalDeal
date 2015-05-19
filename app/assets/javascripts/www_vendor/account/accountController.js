appVendor.controller("AccountController", function ($scope, $rootScope, AccountService, CacheKeys, ReferenceDataCache) {
    $scope.errorMessage = null;
    $scope.data = {};
    ReferenceDataCache.get(CacheKeys.Categories)
        .then(function(categories) {
            $scope.data.categories = categories;
            //Set the reference of offer type from the above array
            $rootScope.vendor.category = $scope.data.categories.find($rootScope.vendor.category);
            $rootScope.vendor.subcategories = $rootScope.vendor.category.subcategories.find($rootScope.vendor.subcategories);
        });
    $scope.updateProfile = function () {
        AccountService.updateProfile($rootScope.vendor)
            .then(function (response) {

            })
            .catch(function (errorMessage) {
                $scope.errorMessage = errorMessage;
            })
    };
});