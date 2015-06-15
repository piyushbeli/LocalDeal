appUser.factory("Deal", ['Utils', 'Offer', function(Utils, Offer) {
    function Deal(data) {
        if (!data) {
            return;
        }
        this.id = data.slug;
        this.title = data.title;
        this.vendor = data.vendor;
        this.offers = Offer.build(data.offers);
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
    };

    Deal.prototype.offerCount = function() {
      return this.offers.length;
    };

    //End
    return Deal;
}])