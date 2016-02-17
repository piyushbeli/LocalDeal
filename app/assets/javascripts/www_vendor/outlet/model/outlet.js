'use strict';

appVendor.factory("Outlet", ['Utils', function(Utils) {
    function Outlet(data) {
        if (!data) {
            return;
        }
        this.id = data.slug;
        this.name = data.name;
        this.mobile = data.mobile;
        this.email = data.email;
        this.latitude = Utils.formatDecimal(data.latitude, 6);
        this.longitude = Utils.formatDecimal(data.longitude, 6);
        this.contactNo = data.contact_no;
        this.city = data.city;
        this.street = data.street;
        this.address = data.address;
        this.cityDetail = {
            place_id: data.city_id,
            latitude: data.city_latitude,
            longitude: data.city_longitude
        };
        this.streetDetail = {
            place_id: data.street_id,
            latitude: data.street_latitude,
            longitude: data.street_longitude
        };
        this.averageRating = data.average_rating;
        this.noOfRaters = data.no_of_raters;
        this.noOfFollowers = data.no_of_followers;
        this.noOfReviews = data.no_of_comments;
    }

    Outlet.build = function(data) {
        if (angular.isArray(data)) {
            var result = [];
            data.forEach(function(item) {
                result.push(new Outlet(item))
            })
            return result;
        } else {
            return new Outlet(data);
        }
    };

    Outlet.prototype.isNew = function() {
        return angular.isUndefined(this.id);
    };

    Outlet.prototype.getCoordinates = function() {
        if (this.latitude && this.longitude) {
            return LatLng(this.latitude, this.longitude);
        } else if (this.streetDetail && !this.isNew()) {
            return LatLng(this.streetDetail.geometry.location.lat(), this.streetDetail.geometry.location.lng());
        } else if (this.cityDetail && !this.isNew()) {
            return LatLng(this.cityDetail.geometry.location.lat(), this.cityDetail.geometry.location.lng());
        }
    };

    Outlet.prototype.getStreetBoundary = function() {
       return !this.isNew() ? LatLng(this.cityDetail.geometry.location.lat(), this.cityDetail.geometry.location.lng()): ''
    }

    //End
    return Outlet;
}])