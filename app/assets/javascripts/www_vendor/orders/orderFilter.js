appVendor.factory("OrderFilter", [function() {
    function OrderFilter(data) {
        if (!data) {
            return;
        }
        this.outlets = data.outlets;
        this.startDate = data.start_date;
        this.endDate = data.end_date;
        this.sortBy = data.sort_by;
        this.orderStatus = data.order_status;
        this.page = data.page;
    };

    OrderFilter.build = function(data) {
        return new OrderFilter(data);
    };

    OrderFilter.prototype.toQueryString = function() {
        var queryString = [];
        if (this.sortBy) {
            queryString.push("sort_by=" + this.sortBy.column);
            queryString.push("sort_order=" + this.sortBy.sortOrder);
        }
        if(this.outlets && this.outlets.notEmpty()) {
            queryString.push("outlets=" + this.outlets);
        }
        if (this.startDate) {
            queryString.push("start_date=" + this.startDate);
        }
        if (this.endDate) {
            queryString.push("end_date=" + this.endDate);
        }
        if (this.orderStatus) {
            queryString.push("order_status=" + this.orderStatus.value);
        }
        if (this.page) {
            queryString.push("page=" + this.page);
        }
        return "?" + queryString.join("&");
    };

    OrderFilter.prototype.toQueryParams = function() {

    };

    return OrderFilter;

    //End
}])