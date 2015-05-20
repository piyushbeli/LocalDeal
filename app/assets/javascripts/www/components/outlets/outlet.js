appUser.factory("Outlet", function() {
    function Outlet(data) {
        if (!data) {
            return;
        }
        this.name = data.name;
        this.vendor = data.vendor; //name (for detail id also)
        this.deals = data.deals; //title (for detail id and rating also)
        this.city = data.city;
        this.street = data.street;
        this.distance = data.distance; //Distance form current location

        //Detail specific
        this.latitude = data.latitude;
        this.longitude = data.longitude;
    };

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

    Outlet.prototype.noOfDeal = function() {
        return this.deals.length;
    };

    Outlet.prototype.location = function() {
        return [this.latitude, this.longitude];
    };

    Outlet.prototype.bestDeal = function() {
        var bestDeal = this.filter(function(item) {
            return item.isBestDeal;
        });
        if (!bestDeal && this.deals.notEmpty()) {
            bestDeal = this.deals[0];
        }
    };

    Outlet.prototype.distance = function() {
        if (this.distance < 1) {
            return this.distance * 1000 + " meters";
        } else {
            return this.distance + " kms"
        }
    }

    //End
    return Outlet;
})