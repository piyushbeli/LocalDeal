appUser.factory("User", function() {
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
    }

    User.build = function(data) {
        return new User(data);
    };

    return User;
})