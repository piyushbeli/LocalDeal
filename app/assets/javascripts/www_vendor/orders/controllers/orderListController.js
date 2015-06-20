appVendor.controller("OrderListController", ['$rootScope', '$scope', '$state', 'States', 'OrderFilter', 'OrderService',
    'CommonConstants',
    function ($rootScope, $scope, $state, States, OrderFilter, OrderService, CommonConstants) {
        $scope.filter = new OrderFilter();
        $scope.sortOptions = CommonConstants.OrderSortCriteria;
        $scope.OrderStatus = CommonConstants.OrderStatus;
        $scope.filter.orderStatus = CommonConstants.OrderStatus.Active;

        var self = this;
        self.refreshItems = function () {
            OrderService.fetchOrders($scope.filter)
                .then(function (orders) {
                    $scope.orders = orders;
                })
                .catch(function (errorMessage) {
                    alert(errorMessage);
                });

        };
        self.refreshItems();

        $scope.showOrderDetail = function (order) {
            $state.go(States.orderDetail, {id: order.orderNo});
        };

        $scope.filterOrders = function () {

        };

        $scope.onChangeSortOption = function (data) {
            $scope.filter.sortBy = data;
            self.refreshItems();
        };

        $scope.$watch('filter.orderStatus', function(newVal, oldVal) {
            if (newVal != oldVal) {
                self.refreshItems();
            }
        });

    }])