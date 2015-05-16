appVendor.constant("HttpRoutes", {
    apiUrl: '/',
    outlet: '/vendor/outlets',
    deal: '/vendor/deals',
    removeOutlet: '/vendor/deals/{deal_id}/outlets/{outlet_id}',
    offer: 'vendor/deals/{deal_id}/offers'
})
    .constant('Constants', {
        apiUrl: 'localhost:3000/vendor#',
        landingState: 'app.deals',
        emailConfirmationUrl: 'http://40ea6b.ngrok.com/vendor#/emailConfirmation'
    })
