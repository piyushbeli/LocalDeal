appCommon
    .constant("CacheKeys", {
        OfferTypes: 'offerTypes',
        Categories: 'categories',
        SubCategories: 'subcategories',
        LastSearchCriteria: 'lastsearchcriteria'
    })
    .constant("CommonHttpRoutes", {
        Categories: '/categories',
        SubCategories: '/subcategories/',
        OfferTypes: '/offertypes'
    })
    .constant("CommonConstants", {
        DateFormat: 'MMMM Do YYYY, h:mm a',
        OrderStatus: {
            Active: 'active',
            Redeemed: 'redeemed',
            Expired: 'expired'
        },
        OrderSortCriteria: [
            {
                column: 'created_at',
                sortOrder: 'ASC',
                value: 'Created Date (Ascending)'
            },
            {
                column: 'created_at',
                sortOrder: 'DESC',
                value: 'Created Date (Descending)'
            },
            {
                column: 'expire_at',
                sortOrder: 'ASC',
                value: 'Expiry Date (Ascending)'
            },
            {
                column: 'expire_at',
                sortOrder: 'DESC',
                value: 'Expiry Date (Descending)'
            }]
    })