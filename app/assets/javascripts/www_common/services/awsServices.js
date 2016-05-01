appCommon.service('AwsService', ['CommonConstants', '$q', function (CommonConstants, $q) {
    AWS.config.update({
        accessKeyId: CommonConstants.awsConfig.accessKey,
        secretAccessKey: CommonConstants.awsConfig.secret
    });
    var s3BucketImages = new AWS.S3({params: {Bucket: CommonConstants.awsConfig.bucketName}});

    this.uploadImagesToS3 = function (file, entity, uploadedBy, type) {

        var deferred = $q.defer();
        var folderType = type + 'Folder';
        var key = [CommonConstants.awsConfig[folderType], entity.type + '-' + entity.id];
        if (uploadedBy) {
            key.push(uploadedBy.type + '-' + uploadedBy.id)
        }
        key.push( file.name);
        key = key.join('/');
        var params = {
            Key: key,
            ContentType: file.type,
            Body: file,
            ServerSideEncryption: 'AES256'
        };
        deferred.resolve(createS3ResourceUrl(key));
        s3BucketImages
            .putObject(params, function (err, data) {
                if (err) {
                    // There Was An Error With Your S3 Config
                    deferred.reject(err.message);
                    return false;
                }
                else {
                    deferred.resolve(createS3ResourceUrl(key));
                }
            })
            .on('httpUploadProgress', function (progress) {
                // Log Progress Information
                console.log(Math.round(progress.loaded / progress.total * 100) + '% done');
            });

        return deferred.promise;
    };

    function createS3ResourceUrl (key) {
        return 'https://s3-us-west-2.amazonaws.com/' + CommonConstants.awsConfig.bucketName + '/' + key;
    }
}]);