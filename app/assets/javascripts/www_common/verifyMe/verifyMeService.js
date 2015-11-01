'use strict'

appCommon.service("VerifyMeService", ['$http', '$q', 'CommonHttpRoutes', function ($http, $q, CommonHttpRoutes) {

    this.verifyMe = function (otp) {
        var url = CommonHttpRoutes.verifyMe,
            deferred = $q.defer(),
            params = {
                otp: otp
            };
        $http.post(url, params)
            .then(function (response) {

            })
            .catch(function (response) {

            });
        return deferred.promise;
    };

    this.sendOTP = function (number) {
        var url = CommonHttpRoutes.sendOTP,
            deferred = $q.defer(),
            params = {
                number: number
            };
        $http.post(url, params)
            .then(function (response) {

            })
            .catch(function (response) {

            });
        return deferred.promise;
    }
}]);