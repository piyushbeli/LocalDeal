appUser.controller("OrderListController", ['$scope', '$state', 'States', 'OrderService',
    function ($scope, $state, States, OrderService) {
        $scope.orders = [];
        OrderService.fetchOrders()
            .then(function (orders) {
                $scope.orders = orders;
            })
            .catch(function () {

            });

        $scope.showOrderDetail = function (order) {
            $state.go(States.orderDetail, {order_no: order.orderNo});
        }
    }])