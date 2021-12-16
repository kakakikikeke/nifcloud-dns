require 'hmac-sha1'
require 'base64'
require 'time'

module Nifcloud
  class Auth
    ALGORITHM = 'HmacSHA1'

    def initialize(access_key, secret_key)
      @access_key = access_key || ENV['ACCESS_KEY']
      @secret_key = secret_key || ENV['SECRET_KEY']
    end

    def signature_header
      @time = Time.now.httpdate
      hmac = HMAC::SHA1.new(@secret_key).update(@time)
      signature = Base64.encode64("#{hmac.digest}")
      "NIFTY3-HTTPS NiftyAccessKeyId=#{@access_key},Algorithm=#{ALGORITHM},Signature=#{signature.chomp}"
    end

    attr_reader :time
  end
end
