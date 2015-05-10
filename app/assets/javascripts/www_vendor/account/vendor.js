appVendor.factory("Vendor", function (Outlet) {
    function Vendor(data) {
        if (!data) {
            return;
        }
        this.id = data.id;
        this.name = data.name;
        this.email = data.email;
        this.website = data.website;
        this.mobile = data.mobile;
        this.city = data.city;
        this.outlets = (data.outlets && Outlet.build(data.outlets)) || [];
    }

    Vendor.build = function (data) {
        return new Vendor(data);
    }

    return Vendor;
})