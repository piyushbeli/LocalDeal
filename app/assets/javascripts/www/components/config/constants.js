appUser.constant('Constants', {
    apiUrl: 'localhost:3000/vendor#',
    landingState: 'app.deals'
})
    .constant("HttpRoutes", {
        apiUrl: '/',
        deals: '/user/deals/?',
        outlets: '/outlets'
        /*city_id={city_id}&category_id={category_id}&subcategory_ids={subcategory_ids}' +
        '&current_location={current_location}&street_location={street_location}&show_near_by={show_near_by}'*/,
        offers: 'vendor/deals/{deal_id}/offers'
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
