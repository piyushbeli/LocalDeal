appUser.factory("SearchCriteria", function(Geocoder, $q, ReferenceDataCache, CacheKeys) {
    function SearchCriteria(data) {
        this.outlets = [];
        this.currentLocation = [];
        this.pageNo = 1;
        this.busy = false;
        this.showLoading = true;
        if (!data) {
            this.subcategories = [];
            this.currentLocation = [];
            return;
        }
        this.city = data.city;
        this.cityDetail = data.cityDetail;
        /*
        for category and subcategories we will use slug every where in ui but while sending the request to server we will
        use id. Both the objects will have id, name and slug all 3 fields.
         */
        this.category = data.category;
        this.subcategories = data.subcategories;
        this.streetLocationDetail = data.streetLocationDetail;
        this.street = data.street;
        this.showOnlyNearBy = data.showOnlyNearBy;
    }

    SearchCriteria.prototype.toQueryString = function() {
        var deferred = $q.defer();
        var query = [];
        if (this.category) {
            query.push("category_id=" + this.category.id);
        }
        if (this.subcategories.notEmpty()) {
            var ids = this.subcategories.map(function(item) {
                return item.id;
            });
            query.push("subcategory_ids={ids}".format({ids: ids})); //Handle this line with care. We need to send the array of ids as per server compatibility
        }
        if (this.currentLocation) {
            query.push("current_location=" + this.currentLocation);
        }
        if (this.street) {
            query.push("street=" + this.street);
        }
        if(this.showOnlyNearBy) {
            query.push("show_only_near_by=" + this.showOnlyNearBy);
        }
        this.getStreetLatLng()
            .then(function (street_location) {
                if (street_location && street_location.notEmpty()) {
                    query.push("street_location=" + street_location);
                }
                deferred.resolve("?" + query.join("&"));
            });
        return deferred.promise;
    };

    SearchCriteria.prototype.clientSideQueryString = function() {
        var queryString = [];
        if (this.street) {
            queryString.push("street=" + this.street);
        }
        if (this.category) {
            queryString.push("category=" + this.category.slug)
        };
        if (this.subcategories.notEmpty()) {
            var ids = this.subcategories.map(function(item) {
                return item.slug;
            });
            queryString.push("subcategories={ids}".format({ids: ids}));
        };
        var commaSpaceRegEx = new RegExp(', ', 'g');
        var spaceRegEx = new RegExp(' ', 'g');
        return queryString.join("&").replace(commaSpaceRegEx, '--').replace(spaceRegEx, '-');
    };

    SearchCriteria.prototype.getStreetLatLng = function() {
        var deferred = $q.defer();
        //If user has selected from autocomplete then use it else geocode the address
        if (this.streetLocationDetail) {
            deferred.resolve([this.streetLocationDetail.geometry.location.lat(), this.streetLocationDetail.geometry.location.lng()]);
        } else {
            Geocoder.geocodeAddress(this.street)
                .then(function(address) {
                    console.log(JSON.stringify(address));
                    deferred.resolve([address.lat, address.lng]);
                })
                .catch(function(error) {
                    console.log(JSON.stringify(error));
                    deferred.resolve(null);
                });
        }
        return deferred.promise;
    };

    SearchCriteria.instanceFromQueryString = function(queryString) {
        var commaSpaceRegEx = new RegExp('--', 'g');
        var spaceRegEx = new RegExp('-', 'g');
        var criteria = new SearchCriteria();
        if (queryString['category']) {
            criteria.category = {
                slug: queryString['category'].replace(commaSpaceRegEx, ', ').replace(spaceRegEx, ' ')
            };
        }
        if (queryString['street']) {
            criteria.street = queryString['street'].replace(commaSpaceRegEx, ', ').replace(spaceRegEx, ' ');
        }
        if (queryString['subcategories']) {
            var subcategories = queryString['subcategories']; //.replace(commaSpaceRegEx, ', ').replace(spaceRegEx, ' ');
            //Don't replace '-' an d '--' for reference data because we want slug instead of name. It make sense only for text column to replace the '-' with space.
            subcategories = subcategories.split(",");
            criteria.subcategories = subcategories.map(function(item) {
                return {slug: item}
            })
        }
        return criteria;
    };

    SearchCriteria.prototype.qualifyForSearch = function() {
        //It should at least have either street address or category.
        return this.street || this.category
    }

    return SearchCriteria;
})