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
        OfferTypes: '/offertypes',
        sendOTP: 'send_otp',
        verifyMe: '/verify_me',
        uploadImage: 'outlets/{outlet_id}/upload/image',
        images: '/images'
    })
    .constant("CommonConstants", {
        appName: 'LocalDeals',
        ItemsPerPage: 10,
        DateFormat: 'MMMM Do YYYY, h:mm a',
        OrderStatus: {
            Active: 'active',
            Redeemed: 'redeemed',
            Expired: 'expired'
        },
        awsConfig: {
            accessKey: 'AKIAJTJYUSVTAVCYJIIQ',
            secret: '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',
            bucketName: 'paylo-images',
            region: 'us-west-2',
            imageFolder: 'images',
            menuFolder: 'menus'
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