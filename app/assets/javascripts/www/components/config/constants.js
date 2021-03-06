appUser.constant('Constants', {
    apiUrl: 'localhost:3000/vendor#',
    landingState: 'app.deals'
})
    .constant("HttpRoutes", {
        apiUrl: '/',
        deals: '/user/deals/?',
        outlets: '/outlets',
        outletReviews: '/outlets/{outlet_id}/comments',
        postComment: '/comments/{comment_id}/comments',
        buyOffer: '/offers/{id}/buy',
        orders: '/orders',
        spamVendor: 'vendors/{vendor_id}/spam',
        spamUser: 'users/{user_id}/spam',
        markAsFavorite: 'outlets/{id}/favorite',
        favoriteOutlets: 'favoriteOutlets'
    })
    .constant('Constants', {
        apiUrl: 'localhost:3000/vendor#',
        landingState: 'app.deals',
        itemsPerPage: 10,
        emailConfirmationUrl: 'http://40ea6b.ngrok.com/vendor#/emailConfirmation'
    })
    .constant("States", {
        root: 'app',
        deals: 'app.outletDetail.deals',
        dealDetail: 'app.outletDetail.dealDetail',
        outlets: 'app.outlets',
        outletDetail: 'app.outletDetail',
        orders: 'app.orders',
        orderDetail: 'app.orderDetail'
    })
