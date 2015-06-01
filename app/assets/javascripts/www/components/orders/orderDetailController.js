appUser.controller("OrderDetailController", ['$scope', '$state', 'States', 'OrderService', 'order',
    function($scope, $state, States, OrderService, order) {
    $scope.order = order;

    $scope.checkIn = function(order) {
        OrderService.checkIn(order)
            .then(function() {

            })
            .catch(function(errorMessage) {
                alert(errorMessage);
            })
    }
}])