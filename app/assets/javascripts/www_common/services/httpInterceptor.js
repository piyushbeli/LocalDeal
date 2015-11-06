appCommon.factory('AuthHttpResponseInterceptor',['$q','$window', function($q, $window){
    return {
        /*responseError: function(rejection) {
            /!*if (rejection.status === 401) {
                alert("Invalid user, your session may have been expired. Please login again");
            }
            return $q.resolve(rejection);*!/
        }*/
    };
}])