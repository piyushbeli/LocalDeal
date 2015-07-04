appCommon.factory('AuthHttpResponseInterceptor',['$q','$window', function($q, $window){
    return {
        response: function(response){
            if (response.status === 401) {
                alert("Invalid user, your session may have been expired. Please login again");
                $window.location.reload();
            }
            return response || $q.when(response);
        },
        responseError: function(rejection) {
            if (rejection.status === 401) {
                alert("Invalid user, your session may have been expired. Please login again");
                $window.location.reload();
            } else {
                return $q.reject(rejection);
            }
        }
    };
}])