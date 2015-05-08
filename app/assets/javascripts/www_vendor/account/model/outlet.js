appVendor.factory("Outlet", function() {
    function Outlet(data) {
        if (!data) {
            return;
        }
        this.name = data.name;
        this.mobile = data.mobile;
    }

    Outlet.build = function(data) {
        if (angular.isArray(data)) {
            var result = [];
            data.forEach(function(item) {
                result.push(new Outlet(item))
            })
            return result;
        } else {
            return new Outlet(data);
        }
    };

    //End
    return Outlet;
})