# frozen_string_literal: true

require 'hmac-sha1'
require 'base64'
require 'time'

module Nifcloud
  # Authentication for nifcloud api v3
  class Auth
    ALGORITHM = 'HmacSHA1'

    def initialize(access_key, secret_key)
      @access_key = access_key || ENV.fetch('ACCESS_KEY', nil)
      @secret_key = secret_key || ENV.fetch('SECRET_KEY', nil)
    end

    def signature_header
      @time = Time.now.httpdate
      hmac = HMAC::SHA1.new(@secret_key).update(@time)
      signature = Base64.encode64(hmac.digest.to_s)
      "NIFTY3-HTTPS NiftyAccessKeyId=#{@access_key},Algorithm=#{ALGORITHM},Signature=#{signature.chomp}"
    end

    attr_reader :time
  end
end
