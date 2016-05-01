appCommon.factory('Menu', [function () {
    function Menu(data) {
        this.url = data.url;
        this.outletId = data.outlet_id;
    }

    Menu.build = function(data) {
        if (angular.isArray(data)) {
            var result = [];
            data.forEach(function(item) {
                result.push(new Menu(item))
            })
            return result;
        } else {
            return new Menu(data);
        }
    };

    return Menu;
}]);