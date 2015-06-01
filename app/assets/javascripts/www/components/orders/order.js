appUser.factory("Order", ['Vendor', 'Outlet', function(Vendor, Outlet) {
    function Order(data) {
        if (!data) {
            return;
        }
        this.orderNo = data.order_no;
        this.vendor = Vendor.build(data.vendor);
        this.whatYouGet = data.what_you_get;
        this.finePrints = data.fine_print ? JSON.parse(data.fine_print): ["Not mentioned"];
        this.instruction = data.instruction;
        this.offerId = data.offer_id;
        this.outlet = Outlet.build(data.outlet);
        this.expireAt = data.expire_at;
    };

    Order.build = function(data) {
        if (angular.isArray(data)) {
            var result = [];
            data.forEach(function(item) {
                result.push(new Order(item))
            })
            return result;
        } else {
            return new Order(data);
        }
    };

    Order.prototype.isExpired = function() {
        return moment(this.expireAt).isBefore(moment())
    };

    Order.prototype.expiresIn = function() {
        return moment(this.expireAt).from(moment());
    };

    return Order;
}])