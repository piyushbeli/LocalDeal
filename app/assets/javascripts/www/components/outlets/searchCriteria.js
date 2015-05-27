appUser.factory("SearchCriteria", function(Geocoder, $q) {
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
        this.category = data.category;
        this.subcategories = data.subcategories;
        this.streetLocationDetail = data.streetLocationDetail;
        this.street = data.street;
        this.showOnlyNearBy = data.showOnlyNearBy;
    }

    SearchCriteria.prototype.toQueryString = function() {
        var deferred = $q.defer();
        var query = [];
/*        if (this.cityDetail) {
            query.push("city_id=" + this.cityDetail.place_id);
        }
        if (this.city) {
            query.push("city=" + this.city);
        }*/
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
   /*     if (this.city) {
            queryString.push("city=" + this.city);
        };*/
        if (this.street) {
            queryString.push("street=" + this.street);
        }
        if (this.category) {
            queryString.push("category=" + this.category.id)
        };
        if (this.subcategories.notEmpty()) {
            var ids = this.subcategories.map(function(item) {
                return item.id;
            });
            queryString.push("subcategories={ids}".format(ids));
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
    /*    if (queryString['city']) {
            criteria.city = queryString['city'].replace(commaSpaceRegEx, ', ').replace(spaceRegEx, ' ');
        }*/
        if (queryString['category']) {
            criteria.category = queryString['category'].replace(commaSpaceRegEx, ', ').replace(spaceRegEx, ' ');
        }
        if (queryString['street']) {
            criteria.street = queryString['street'].replace(commaSpaceRegEx, ', ').replace(spaceRegEx, ' ');
        }
        if (queryString['subcategories']) {
            criteria.subcategoriesb = queryString['subcategoriesb'].replace(commaSpaceRegEx, ', ').replace(spaceRegEx, ' ');
        }
        return criteria;
    };

    return SearchCriteria;
})