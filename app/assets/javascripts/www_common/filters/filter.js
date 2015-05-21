appCommon.filter("distance", function() {
    /**
     * @param d will be in kms
     */
    return function(d) {
        if (!d) {
            return;
        }
        return d < 1 ? ((d * 1000).toFixed(2) + " meters") : (d.toFixed(2) + " kms");
    }
})