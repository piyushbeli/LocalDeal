appVendor.controller("OrderListController", ['$rootScope', '$scope', '$state', 'States', 'OrderFilter', 'OrderService',
    function($rootScope, $scope, $state, States, OrderFilter, OrderService) {
        $scope.filter = new OrderFilter();

        OrderService.fetchOrders($scope.filter)
            .then(function(orders) {
                $scope.orders = orders;
            })
            .catch(function(errorMessage) {
                alert(errorMessage);
            });

        $scope.showOrderDetail = function(order) {
            $state.go(States.orderDetail, {id: order.orderNo});
        };

        $scope.filterOrders = function() {

        };

    }])