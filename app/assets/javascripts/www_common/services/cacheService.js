appCommon
    .service("ReferenceDataCache", function ($http, $q, CacheKeys, CacheFactory, CommonHttpRoutes) {
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
                url = self.buildHttpUrl(key);
            if (referenceDataCache.get(key)) {
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

    })
    /*.service("SubCategoryCache", function ($http, $q, CacheKeys, DSCacheFactory, CommonHttpRoutes) {
        var self = this;
        var subCategoryCache = DSCacheFactory('LOCAL_DEAL_SUB_CATEGORY_CACHE');
        subCategoryCache.setOptions({
            maxAge: 86400,
            deleteOnExpire: 'aggressive'
        });

        self.get = function (id) {
            var deferred = $q.defer(),
                cacheKey = CacheKeys.SubCategories + "-" + id;
            if (subCategoryCache.get(cacheKey)) {
                deferred.resolve(subCategoryCache.get(cacheKey));
            } else {
                $http.get(CommonHttpRoutes.SubCategories)
                    .success(function (response) {
                        subCategoryCache.set(cacheKey, response.data);
                        deferred.resolve(response.data);
                    });
            }
        };

    })

    .service("OfferTypeCache", function ($http, $q, CacheKeys, DSCacheFactory, CommonHttpRoutes) {
        var self = this;
        var offerTypeCache = DSCacheFactory('LOCAL_DEAL_OFFER_TYPE_CACHE');
        offerTypeCache.setOptions({
            maxAge: 86400,
            deleteOnExpire: 'aggressive'
        });

        self.get = function (key) {
            var deferred = $q.defer();
            if (offerTypeCache.get(key)) {
                deferred.resolve(offerTypeCache.get(key));
            } else {
                $http.get(CommonHttpRoutes.SubCategories)
                    .success(function (response) {
                        offerTypeCache.set(key, response.data);
                        deferred.resolve(response.data);
                    });
            }
        };

    });*/