appUser.controller("OrderDetailController", ['$scope', '$state', 'States', 'OrderService', 'order', '$window',
    function ($scope, $state, States, OrderService, order, $window) {

        $scope.order = order;

        $scope.checkIn = function (order) {
            OrderService.checkIn(order)
                .then(function () {

                })
                .catch(function (errorMessage) {
                    alert(errorMessage);
                })
        }
    }])