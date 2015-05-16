appVendor.factory("Offer", function(Utils) {
    function Offer(data) {
        if (!data) {
            return;
        }
        this.id = data.id;
        this.dealId = data.deal_id;
        this.whatYouGet = data.what_you_get;
        this.instruction = data.instruction;
        this.finePrint = data.fine_print;
        this.discount = data.discount;
        this.offerType = data.offer_type;
        this.startTime = data.start_time;
        this.expireTime = data.expire_time;
    }

    Offer.build = function(data) {
        if (angular.isArray(data)) {
            var result = [];
            data.forEach(function(item) {
                result.push(new Offer(item))
            })
            return result;
        } else {
            return new Offer(data);
        }
    };

    Offer.prototype.isNew = function() {
        return angular.isUndefined(this.id);
    };

    Offer.prototype.isExpired = function() {
        return moment(this.expireTime).isBefore(moment())
    };

    //End
    return Offer;
})