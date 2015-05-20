appUser.factory("SearchCriteria", function() {
    function SearchCriteria() {
        //Fields are not camel cased instead according to query string
        this.cityDetail = null;
        this.category = null;
        this.subcategories = [];
        this.currentLocation = [];
        this.streetLocationDetail = null;
        this.showOnlyNearBy = false;
    }

    SearchCriteria.prototype.toQueryString = function() {
        var query = [];
        if (this.cityDetail) {
            query.push("city_id=" + this.cityDetail.place_id);
        }
        if (this.category) {
            query.push("category_id=" + this.category.id);
        }
        if (this.subcategories.notEmpty()) {
            var ids = this.subcategories.map(function(item) {
                return item.id;
            });
            query.push("subcategory_ids=" + ids);
        }
        if (this.currentLocation) {
            query.push("current_location=[{location}]".format({location: this.currentLocation}));
        }
        if (this.streetLocationDetail) {
            query.push("street_location=[{street}]".format({street: this.getStreetLatLng()}));
        }
        if(this.showNearBy) {
            query.push("show_only_near_by=" + this.showOnlyNearBy);
        }
        return query.join("&");
    };

    SearchCriteria.prototype.getStreetBoundary = function() {
        //return this.cityDetail ? LatLng(this.cityDetail.geometry.location.lat(), this.cityDetail.geometry.location.lng()): ''
        return this.cityDetail ? [this.cityDetail.geometry.location.lat(), this.cityDetail.geometry.location.lng()]: ''
    };

    SearchCriteria.prototype.getStreetLatLng = function() {
        return [this.streetLocationDetail.geometry.location.lat(), this.streetLocationDetail.geometry.location.lng()]
    }

    return SearchCriteria;
})