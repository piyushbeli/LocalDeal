appUser.factory("Review", ['Utils', 'Offer', 'Reviewer', function(Utils, Offer, Reviewer) {
    function Review(data) {
        if (!data) {
            return;
        }
        this.id = data.id;
        this.title = data.title;
        this.body = data.body;
        this.comments = data.comments || [];
        this.createdAt = data.created_at;
        this.reviewedBy = Reviewer.build(data.reviewer);
        this.newComment = new Review();
    }

    Review.build = function(data) {
        if (angular.isArray(data)) {
            var result = [];
            data.forEach(function(item) {
                result.push(new Review(item))
            })
            return result;
        } else {
            return new Review(data);
        }
    };


    //End
    return Review;
}])