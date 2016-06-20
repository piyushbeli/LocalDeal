appVendor.controller("OrderListController", ['$rootScope', '$scope', '$state', 'States', 'OrderFilter', 'OrderService',
    'CommonConstants',
    function ($rootScope, $scope, $state, States, OrderFilter, OrderService, CommonConstants) {
        $scope.filter = new OrderFilter();
        $scope.sortOptions = CommonConstants.OrderSortCriteria;
        $scope.OrderStatus = CommonConstants.OrderStatusList;
        $scope.filter.orderStatus = CommonConstants.OrderStatusList[0];
        $scope.filter.sortBy = CommonConstants.OrderSortCriteria[0];
        $scope.filter.page = $scope.filter.page || 1;
        $scope.itemsPerPage = CommonConstants.ItemsPerPage;

        var self = this;
        self.refreshItems = function () {
            OrderService.fetchOrders($scope.filter)
                .then(function (response) {
                    $scope.orders = response.items;
                    $scope.totalItems = response.totalItems;
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

        $scope.$watch('filter.orderStatus', function (newVal, oldVal) {
            if (newVal != oldVal) {
                self.refreshItems();
            }
        });

        $scope.$watch('filter.sortBy', function (newVal, oldVal) {
            if (newVal != oldVal) {
                self.refreshItems();
            }
        });

        $scope.onChangePageNo = function (data) {
            self.refreshItems();
        };

        $scope.findOrdersByOrderNo = function (key) {
            OrderService.findOrdersByOrderNo(key)
                .then(function (response) {
                    $scope.orders = response.items;
                    $scope.totalItems = response.totalItems;
                })
                .catch(function (errorMessage) {
                    alert(errorMessage);
                });
        }

    }])