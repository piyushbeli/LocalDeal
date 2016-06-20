appVendor
    .constant('Constants', {
        apiUrl: 'localhost:3000/vendor#',
        landingState: 'app.deals',
        emailConfirmationUrl: 'http://40ea6b.ngrok.com/vendor#/emailConfirmation'
    })
    .constant("HttpRoutes", {
        apiUrl: '/',
        outlet: '/vendor/outlets',
        deal: '/vendor/deals',
        removeOutlet: '/vendor/deals/{deal_id}/outlets/{outlet_id}',
        addOutlets: 'vendor/deals/{deal_id}/outlets',
        offer: 'vendor/deals/{deal_id}/offers',
        orders: '/orders',
        ordersByOrderNo: '/orders_by_order_no?q={order_no}'
    })
    .constant('Constants', {
        apiUrl: 'localhost:3000/vendor#',
        landingState: 'app.deals',
        emailConfirmationUrl: 'http://40ea6b.ngrok.com/vendor#/emailConfirmation'
    })
    .constant("States", {
        login: 'login',
        verifyMe: 'app.verifyMe',
        deals: 'app.deals',
        outlets: 'app.outlets',
        orders: 'app.orders',
        dealDetail: 'app.dealDetail',
        offerDetail: 'app.dealDetail.offerDetail',
        newDeal: 'app.newDeal',
        newOffer: 'app.dealDetail.newOffer',
        outletDetail: 'app.outletDetail',
        newOutlet: 'app.newOutlet',
        orderDetail: 'app.orderDetail'
    })
