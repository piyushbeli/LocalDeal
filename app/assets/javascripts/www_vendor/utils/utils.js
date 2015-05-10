appVendor.constant("Utils", {
    formatDecimal: function(decimalNumber, decimals) {
        return Number.parseFloat(Number.parseFloat(decimalNumber).toFixed(decimals));
    }
})