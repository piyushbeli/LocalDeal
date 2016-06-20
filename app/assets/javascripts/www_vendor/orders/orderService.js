appVendor.service("OrderService", ['$http', '$q', 'HttpRoutes', 'Order',  function($http, $q, HttpRoutes, Order) {
    var self = this;

    self.fetchOrders = function(filter) {
        var deferred = $q.defer(),
            url = HttpRoutes.orders + filter.toQueryString();

        $http.get(url)
            .then(function(response) {
                var result = {
                    items: Order.build(response.data.items),
                    totalItems: response.data.total_items || 0
                }
                deferred.resolve(result);
            })
            .catch(function(response) {
                var errorMessage = response.data.errors && response.data.errors.join("\n");
                deferred.reject(errorMessage);
            });
        return deferred.promise;
    };

    self.fetchOrder = function(orderNo) {
        var deferred = $q.defer(),
            url = HttpRoutes.orders + "/" + orderNo;
        $http.get(url)
            .then(function(response) {
                deferred.resolve(Order.build(response.data));
            })
            .catch(function(response) {
                var errorMessage = response.data.errors && response.data.errors.join("\n");
                deferred.reject(errorMessage);
            });
        return deferred.promise;
    };

    self.findOrdersByOrderNo = function (key) {
        var deferred = $q.defer();
        var url = HttpRoutes.ordersByOrderNo.format({order_no: key});
        
        $http.get(url)
            .then(function (response) {
                deferred.resolve({items: Order.build(response.data.items), totalItems: response.data.total_items});
            })
            .catch(function(response) {
                var errorMessage = response.data.errors && response.data.errors.join("\n");
                deferred.reject(errorMessage);
            });
        return deferred.promise;
    }

}])