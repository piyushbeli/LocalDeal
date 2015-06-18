appUser.service("LoginService", ['$modal', function ($modal) {
    var self = this;

    self.loginDialog = null;

    self.openLoginDialog = function () {
        self.loginDialog = $modal.open({
            templateUrl: 'user/nav/login.html',
            controller: 'LoginController'
        });
    };
}])