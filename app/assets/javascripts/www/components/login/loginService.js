app.service("LoginService", function ($modal) {
    var self = this;

    self.loginDialog = null;

    self.openLoginDialog = function () {
        self.loginDialog = $modal.open({
            templateUrl: 'nav/login.html',
            controller: 'LoginController'
        });
    };
})