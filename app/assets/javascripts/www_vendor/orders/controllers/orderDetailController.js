appVendor.controller("OrderDetailController", ['$rootScope', '$scope', '$state', 'States', 'order',
    function($rootScope, $scope, $state, States, order) {

        $scope.order = order;
        //Keeping this controller for future where we can send messages to user for the order update
        
}])