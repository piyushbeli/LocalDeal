appUser.factory("Deal", function(Utils, Offer, Review) {
    function Deal(data) {
        if (!data) {
            return;
        }
        this.id = data.id;
        this.title = data.title;
        this.vendor = data.vendor;
        this.offers = Offer.build(data.offers);
        this.reviews = Review.build(data.reviews);
        this.reviewCount = data.review_count;
    }

    Deal.build = function(data) {
        if (angular.isArray(data)) {
            var result = [];
            data.forEach(function(item) {
                result.push(new Deal(item))
            })
            return result;
        } else {
            return new Deal(data);
        }
    };

    Deal.prototype.getOffer = function(offerId) {
        this.offers.forEach(function(item) {
            if (item.id == offerId) {
                return item;
            }
        });
        return null;
    }

    //End
    return Deal;
})