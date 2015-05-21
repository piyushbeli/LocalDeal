appCommon.filter("distance", function() {
    /**
     * @param d will be in kms
     */
    return function(d) {
        if (d < 1) {
            return d * 1000
        }
    }
})