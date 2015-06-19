appVendor.factory("OrderFilter", [function() {
    function OrderFilter(data) {
        if (!data) {
            return;
        }
        this.outlets = data.outlets;
        this.startDate = data.startDate;
        this.endDate = data.endDate;
    };

    OrderFilter.build = function(data) {
        return new OrderFilter(data);
    };

    OrderFilter.prototype.toQueryString = function() {
        return "";
    };

    return OrderFilter;

    //End
}])