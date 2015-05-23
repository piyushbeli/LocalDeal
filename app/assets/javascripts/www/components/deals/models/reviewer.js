appUser.factory("Reviewer", function(Utils, Offer, User) {
    function Reviewer(data) {
        if (!data) {
            return;
        }
        this.id = data.id;
        this.name = data.name;
        this.label = data.label;
        this.type = data.type; //A user or deal's vendor
        this.photoUrl = data.photoUrl;
    }

    Reviewer.build = function(data) {
        return new Reviewer(data);
    };

    //End
    return Reviewer;
})