appVendor.factory("Offer", function(Utils, ReferenceDataCache, CacheKeys) {
    function Offer(data) {
        if (!data) {
            this.startTime =  new Date();
            this.expireTime = new Date();
            return;
        }
        var self = this;
        this.id = data.id;
        this.dealId = data.deal_id;
        this.whatYouGet = data.what_you_get;
        this.instruction = data.instruction;
        this.finePrint = data.fine_print;
        this.discount = data.discount ? Number.parseInt(data.discount) : null;
        this.offerType = data.offer_type;
        this.startTime = data.start_time ? new Date(data.start_time) : new Date();
        this.expireTime = data.expire_time ? new Date(data.expire_time) : new Date();
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