appUser.service("OrderService", function($http, $q, HttpRoutes, Order) {
    var self = this;

    self.fetchOrders = function() {
        var deferred = $q.defer(),
            url = HttpRoutes.orders;
        $http.get(url)
            .then(function(response) {
                deferred.resolve(Order.build(response.data));
            })
            .catch(function(response) {
                var errorMessage = response.data.errors.join("\n");
                deferred.reject(errorMessage);
            });
        return deferred.promise;
    };

    self.fetchOrderDetail = function(orderNo) {
        var deferred = $q.defer(),
            url = HttpRoutes.orders + "/" + orderNo;
        $http.get(url)
            .then(function(response) {
                deferred.resolve(Order.build(response.data));
            })
            .catch(function(response) {
                var errorMessage = response.data.errors.join("\n");
                deferred.reject(errorMessage);
            });
        return deferred.promise;
    };

    self.checkIn = function(order) {

    };
})