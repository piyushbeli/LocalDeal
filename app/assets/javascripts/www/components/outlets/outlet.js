appUser.factory("Outlet", ['Deal', 'Review', function(Deal, Review) {
    function Outlet(data) {
        if (!data) {
            return;
        }
        this.id = data.slug;
        this.name = data.name;
        //We have injected Outlet into Vendor so can not inject Vendor here, it should be Vendor.build(data.vendor) otherwise
        this.vendor = data.vendor; //name (for detail id also)
        this.deals = Deal.build(data.deals); //title (for detail id and rating also)
        this.city = data.city;
        this.street = data.street;
        this.distance = data.distance; //Distance form current location
        this.markedAsFavorite = data.marked_as_favorite;
        this.reviews = Review.build(data.reviews);
        this.rating = data.rating;

        //Detail specific
        this.reviewCount = data.review_count;
        this.userRating = data.user_rating * 2; //On UI we are showing 10 stars instead of 5
        this.noOfRaters = data.no_of_raters;
        this.latitude = data.latitude;
        this.longitude = data.longitude;
    };

    Outlet.build = function(data) {
        if (angular.isArray(data)) {
            var result = [];
            data.forEach(function(item) {
                result.push(new Outlet(item))
            })
            return result;
        } else {
            return new Outlet(data);
        }
    };

    Outlet.prototype.noOfDeal = function() {
        return this.deals.length;
    };

    Outlet.prototype.location = function() {
        return [this.latitude, this.longitude];
    };

    Outlet.prototype.bestDeal = function() {
        var bestDeal = this.deals.filter(function(item) {
            return item.isBestDeal;
        });
        if (!bestDeal.notEmpty() && this.deals.notEmpty()) {
            return this.deals[0];
        }
        return bestDeal[0];
    };

    Outlet.prototype.dealsExcept = function(deal) {
        var remainingDeals = this.deals.filetr(function(item) {
            return item.id != deal.id;
        });
        return remainingDeals;
    };

    Outlet.prototype.findDeal = function(dealId) {
        var deals = this.deals.filter(function(item) {
            return item.id == dealId
        });
        return deals.notEmpty() ? deals[0] : null;
    };

    Outlet.prototype.distance = function() {
        if (this.distance < 1) {
            return this.distance * 1000 + " meters";
        } else {
            return this.distance + " kms"
        }
    }

    //End
    return Outlet;
}])