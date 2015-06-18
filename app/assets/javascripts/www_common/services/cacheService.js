appCommon
    .service("ReferenceDataCache", ['$http', '$q', 'CacheKeys', 'CacheFactory', 'CommonHttpRoutes',
        function ($http, $q, CacheKeys, CacheFactory, CommonHttpRoutes) {
        var self = this;
        if (!CacheFactory.get('LOCAL_DEAL_REFERENCE_DATA_CACHE')) {
            CacheFactory.createCache('LOCAL_DEAL_REFERENCE_DATA_CACHE', {
                maxAge: 86400000, //1 day
                deleteOnExpire: 'aggressive',
                storageMode: 'localStorage'
            });
        }
        var referenceDataCache = CacheFactory.get('LOCAL_DEAL_REFERENCE_DATA_CACHE');

        self.buildHttpUrl = function(key) {
            if (key == CacheKeys.Categories) {
                return CommonHttpRoutes.Categories;
            } else if (key == CacheKeys.SubCategories) {
                return CommonHttpRoutes.SubCategories;
            } else if (key == CacheKeys.OfferTypes) {
                return CommonHttpRoutes.OfferTypes;
            }
        }

        self.get = function (key) {
            var deferred = $q.defer(),
                url = self.buildHttpUrl(key),
                values = referenceDataCache.get(key);
            if (values && values.notEmpty()) {
                deferred.resolve(referenceDataCache.get(key));
            } else {
                $http.get(url)
                    .success(function (response) {
                        referenceDataCache.put(key, response);
                        deferred.resolve(response);
                    });
            }
            return deferred.promise;
        };

    }])
.service("CommonCache", ['CacheFactory', function(CacheFactory) {
        var self = this;
        if (!CacheFactory.get('LOCAL_DEAL_COMMON_DATA_CACHE')) {
            CacheFactory.createCache('LOCAL_DEAL_COMMON_DATA_CACHE', {
                maxAge: 30*86400000, //30 day
                deleteOnExpire: 'aggressive',
                storageMode: 'localStorage'
            });
        }
        var commonDataCache = CacheFactory.get('LOCAL_DEAL_COMMON_DATA_CACHE');

        self.get = function(key){
            return commonDataCache.get(key);
        };

        self.set = function(key, val) {
            commonDataCache.put(key, val);
        };
}])