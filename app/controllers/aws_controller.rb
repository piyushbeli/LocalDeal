class AwsController < ApplicationController
  include CommonResourceController

  def get_s3_upload_key()
    bucket = ENV['S3_BUCKET_NAME']
    access_key = ENV['S3_UPLOAD_ACCESS_KEY']
    secret = ENV['S3_UPLOAD_SECRET_ACCESS_KEY']
    expiration = 5.minutes.from_now.utc.strftime('%Y-%m-%dT%H:%M:%S.000Z')
    max_filesize = 10.megabytes
    acl = 'public-read'
    sas = '201' # Tells amazon to redirect after success instead of returning xml
    policy = Base64.encode64(
        "{'expiration': '#{expiration}',
          'conditions': [
            {'bucket': '#{bucket}'},
            {'acl': '#{acl}'},
            {'Content-Type': 'image/jpeg'},
            {'Content-Disposition': 'attachment'},
            {'Cache-Control': 'max-age=31536000'},

            ['content-length-range', 1, #{max_filesize}]
          ]}
        ").gsub(/\n|\r/, '')
    signature = Base64.encode64(OpenSSL::HMAC.digest(OpenSSL::Digest::Digest.new('sha1'), secret, policy)).gsub(/\n| |\r/, '')
    #{:access_key => access_key, :key => key, :policy => policy, :signature => signature, :sas => sas, :bucket => bucket, :acl => acl, :expiration => expiration}
    render json: {data: {policy: policy, signature: signature, aws_access_key: access_key}, status: 200}
  end

end