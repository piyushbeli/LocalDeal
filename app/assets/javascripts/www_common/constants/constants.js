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
        uploadMenu: 'outlets/{outlet_id}/upload/menu',
        images: '/images',
        menus: '/outlets/{outlet_id}/menus'
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
        OrderStatusList: [
            {text: 'Active', value: 'active'},
            {text: 'Redeemed', value: 'redeemed'},
            {text: 'Expired', value: 'expired'}
        ],
        awsConfig: {
            accessKey: 'AKIAJTJYUSVTAVCYJIIQ',
            secret: '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',
            //New EC2 instance
            /*accessKey: 'AKIAJYADBSJFRWNHZG4Q',
            secret: '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',*/
            bucketName: 'paylo-images',
            region: 'us-west-2',
            imageFolder: 'images',
            menuFolder: 'menus'
        },
        OrderSortCriteria: [
            {
                column: 'expire_at',
                sortOrder: 'ASC',
                text: 'Expiry Date (Ascending)'
            },
            {
                column: 'expire_at',
                sortOrder: 'DESC',
                text: 'Expiry Date (Descending)'
            },
            {
                column: 'created_at',
                sortOrder: 'ASC',
                text: 'Created Date (Ascending)'
            },
            {
                column: 'created_at',
                sortOrder: 'DESC',
                text: 'Created Date (Descending)'
            }]
    })