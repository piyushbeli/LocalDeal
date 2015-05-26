appCommon.factory("Vendor", function (Outlet) {
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
        this.spammed = data.spammed; //Whether spammed by current user (not valid for vendor login)
    }

    Vendor.build = function (data) {
        return new Vendor(data);
    }

    return Vendor;
})