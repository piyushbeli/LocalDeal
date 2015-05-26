appCommon.constant("Utils", {
    formatDecimal: function (decimalNumber, decimals) {
        return Number.parseFloat(Number.parseFloat(decimalNumber).toFixed(decimals));
    },

    googlePlaceAutoCompleteOptionsCity: function(){
        return {
            types: '(cities)',
            country: 'in',
            watchEnter: true
        }
    },
    googlePlaceAutoCompleteOptionsStreet: function(boundry){
       return {
           types: '(regions)',
           country: 'in',
           //bounds: boundry ? boundry : "",
           watchEnter: true
       }
    }
})