appCommon.constant("ValdrConfig", {
    //Login form
    'Login': {
        'userName': {
            'email': {
                'message': 'User name must be a valid email address'
            },
            'required': {
                'message': 'User name can not be blank'
            }
        },
        'password': {
            'size': {
                'min': 6,
                'max': 80,
                'message': 'Password length must be between 6 to 80'
            },
            'required': {
                'message': 'Password can not be blank'
            }
        }
    },

    //Signup form
    SignUp: {
        name: {
            required: {
                message: 'Name can not be blank'
            }
        },
        mobile: {
            size: {
                min: 10,
                max: 10,
                message: 'Mobile should have exactly 10 digits'
            },
            required: {
                message: 'Mobile can not be blank'
            }
        },
        email: {
            email: {
                message: 'Email is not in valid email format'
            },
            required: {
                message: 'Email can not be blank'
            }
        },
        password: {
            size: {
                min: 6,
                max: 80,
                message: 'Password length must be between 6 to 80'
            },
            required: {
                message: 'Password can not be blank'
            }
        },
        confirmPassword: {

        }
    },

    //Deal form
    Deal: {
        title: {
            required: {
                message: "Title can not be blank"
            },
            maxLength: 250
        },
        description: {
            required: {
                message: 'Description can not be blank'
            }
        }
    },

    //Outlet form
    Outlet: {
        name: {
            required: {
                message: 'Name can not be blank'
            },
            size: {
                min: 2,
                max: 250
            }
        },
        city: {
            required: {
                message: 'City  can not be blank'
            }
        },
        street: {
            required: {
                message: 'Street can not be blank'
            }
        },
        latitude: {
            required: {
                message: 'Please move the marker on the map to set the location of outlet'
            }
        },
        longitude: {
            required: {
                message: 'Please move the marker on the map to set the location of outlet'
            }
        },
        mobile: {
            size: {
                min: 10,
                max: 10,
                message: 'Mobile should have exactly 10 digits'
            }
        },
        email: {
            email: {
                message: 'Email is not in valid email format'
            }
        }
    },

    //Offer form
    Offer: {
        whatYouGet: {
            required: {
                message: "Please provide one liner about this offer"
            },
            size: {
                min: 6,
                max: 250,
                message: 'What you get should be between 6 to 250 chars'
            }
        },
        finePrints: {
            required: {
                message: 'Fine prints can not be blank'
            }
        }
    }
})