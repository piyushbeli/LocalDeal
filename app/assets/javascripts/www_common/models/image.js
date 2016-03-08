appCommon.factory('Image', [function () {
    function Image(data) {
        this.url = data.url;
        this.outletId = data.outlet_id;
        this.offerId = data.offer_id;
        this.commentId = data.comment_id;
    }

    Image.build = function(data) {
        if (angular.isArray(data)) {
            var result = [];
            data.forEach(function(item) {
                result.push(new Image(item))
            })
            return result;
        } else {
            return new Image(data);
        }
    };

    return Image;
}]);