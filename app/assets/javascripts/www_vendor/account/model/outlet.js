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
        this.city_id = data.city_id;
        this.address = data.address;
        this.placeDetail = {
            place_id: data.city_id
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

    //End
    return Outlet;
})