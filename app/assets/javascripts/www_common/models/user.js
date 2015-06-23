appCommon.factory("User", function() {
    function User(data) {
        if (!data) {
            return;
        }
        this.id = data.id;
        this.name = data.name;
        this.email = data.email;
        this.mobile = data.mobile;
        this.label = data.label;
        this.photoUrl = data.photoUrl;
        this.favoriteCategories = data.favorite_categories;
        this.favoriteCategories.forEach(function(item) {
            //item.selected = true; //Set the tick property of select
        });
    }

    User.build = function(data) {
        return new User(data);
    };

    return User;
})