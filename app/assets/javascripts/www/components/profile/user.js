appUser.factory("User", function() {
    function User(data) {
        if (!data) {
            return;
        }
        this.name = data.name;
        this.email = data.email;
        this.mobile = data.mobile;
        this.label = data.label;
    }

    User.build = function(data) {
        return new User(data);
    };
})