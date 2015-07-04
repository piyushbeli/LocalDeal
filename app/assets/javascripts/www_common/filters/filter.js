appCommon
    .filter("distance", function () {
        /**
         * @param d will be in kms
         */
        return function (d) {
            if (!d) {
                return 'NA';
            }
            return d < 1 ? ((d * 1000).toFixed(2) + " meters") : (d.toFixed(2) + " kms");
        }
    })
    .filter("datetime", ['CommonConstants', function (CommonConstants) {
        return function (input) {
            if (!input) {
                return "";
            }
            return moment(input).format(CommonConstants.DateFormat)
        }
    }])