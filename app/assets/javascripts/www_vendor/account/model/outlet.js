appVendor.factory("Outlet", function(Utils) {
    function Outlet(data) {
        if (!data) {
            return;
        }
        this.id = data.id;
        this.name = data.name;
        this.mobile = Number.parseFloat(data.mobile);
        this.email = data.email;
        this.latitude = Utils.formatDecimal(data.latitude, 6);
        this.longitude = Utils.formatDecimal(data.longitude, 6);
        this.contactNo = Number.parseFloat(data.contact_no);
        this.city = data.city;
        this.street = data.street;
        this.address = data.address;
        this.cityDetail = {
            place_id: data.city_id
        };
        this.streetDetail = {
            place_id: data.street_id
        };
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
            return LatLng(this.streetDetail.geometry.location.lat(), this.longitude.geometry.location.lng());
        } else if (this.cityDetail && !this.isNew()) {
            return LatLng(this.cityDetail.geometry.location.lat(), this.cityDetail.geometry.location.lng());
        }
    };

    Outlet.prototype.getStreetBoundary = function() {
       return !this.isNew() ? LatLng(this.cityDetail.geometry.location.lat(), this.cityDetail.geometry.location.lng()): ''
    }

    //End
    return Outlet;
})