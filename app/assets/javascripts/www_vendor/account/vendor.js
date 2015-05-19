appVendor.factory("Vendor", function (Outlet) {
    function Vendor(data) {
        if (!data) {
            return;
        }
        this.id = data.id;
        this.name = data.name;
        this.email = data.email;
        this.website = data.website;
        this.mobile = Number.parseInt(data.mobile);
        this.city = data.city;
        this.outlets = data.outlets ? Outlet.build(data.outlets) : [];
        this.deals = []; //We will add the deals whenever it would be fetched
        this.category = {
            id: data.category_id
        };
        this.subcategories = data.subcategories;
    }

    Vendor.build = function (data) {
        return new Vendor(data);
    }

    return Vendor;
})