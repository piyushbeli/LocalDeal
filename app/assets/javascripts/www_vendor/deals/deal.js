appVendor.factory("Deal", function(Utils) {
    function Deal(data) {
        if (!data) {
            return;
        }
        this.id = data.id;
        this.title = data.title;
        this.vendor = data.vendor;
        this.outlets = data.outlets;
        this.offers = data.offers;

        //List specific
        this.noOfOutlets = data.no_of_outlets;
    }

    Deal.build = function(data) {
        if (angular.isArray(data)) {
            var result = [];
            data.forEach(function(item) {
                result.push(new Deal(item))
            })
            return result;
        } else {
            return new Deal(data);
        }
    };

    Deal.prototype.isNew = function() {
        return angular.isUndefined(this.id);
    };

    Deal.prototype.getOffer = function(offerId) {
        this.offers.forEach(function(item) {
            if (item.id == offerId) {
                return item;
            }
        });
        return null;
    }

    //End
    return Deal;
})