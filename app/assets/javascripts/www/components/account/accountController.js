appUser.controller("AccountController", ['$scope', '$rootScope', 'ReferenceDataCache', 'AccountService', 'CacheKeys', 'user', 'Utils',
    function ($scope, $rootScope, ReferenceDataCache, AccountService, CacheKeys, user, Utils) {
        $scope.selectedCategories = user.favoriteCategories;
        $scope.googlePlaceAutoCompleteOptionsCity = Utils.googlePlaceAutoCompleteOptionsCity();

        ReferenceDataCache.get(CacheKeys.Categories)
            .then(function (categories) {
                $scope.categories = categories;
                $scope.categories.forEach(function(item) {
                    if ($scope.selectedCategories.contains(item)) {
                        item.selected = true;
                    }
                })
            });

        $scope.updateProfile = function () {
            AccountService.updateProfile($rootScope.user)
                .then(function () {

                })
                .catch(function (errorMessage) {
                    alert(errorMessage);
                });
        };

        $scope.updateFavoriteCategories = function() {
            AccountService.updateFavoriteCategories($scope.selectedCategories)
                .then(function(selectedCategories) {
                    $rootScope.user.favoriteCategories = selectedCategories;
                })
                .catch(function(errorMessage) {
                    alert(errorMessage);
                })
        }

    }])