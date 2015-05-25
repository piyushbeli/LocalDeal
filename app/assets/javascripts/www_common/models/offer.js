appCommon.factory("Offer", function(Utils) {
    function Offer(data) {
        if (!data) {
            this.startAt =  new Date();
            this.expireAt = new Date();
            return;
        }
        this.id = data.id;
        this.dealId = data.deal_id;
        this.whatYouGet = data.what_you_get;
        this.instruction = data.instruction;
        this.finePrint = data.fine_print ? JSON.parse(data.fine_print).join("\n") : null;
        //for user we will need fine print as an array.
        this.finePrints = data.fine_print ? JSON.parse(data.fine_print) : ["Not mentioned"];
        this.discount = data.discount ? Number.parseInt(data.discount) : null;
        this.offerType = data.offer_type;
        this.startAt = data.start_at ? new Date(data.start_at) : new Date();
        this.expireAt = data.expire_at ? new Date(data.expire_at) : new Date();
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
        return moment(this.expireAt).isBefore(moment())
    };

    Offer.prototype.expiresIn = function() {
        return moment(this.expireAt).from(moment());
    };

    //End
    return Offer;
})