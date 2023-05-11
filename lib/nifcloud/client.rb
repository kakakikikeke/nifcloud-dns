# frozen_string_literal: true

require 'nifcloud/auth'
require 'nifcloud/dns/response'
require 'net/https'

module Nifcloud
  # Client for nifcloud dns
  class Client < Auth
    ENDPOINT = 'https://dns.api.nifcloud.com/'
    VERSION = '2012-12-12N2013-12-16'
    AUTHORIZATION_HEADER = 'X-Nifty-Authorization'
    DATE_HEADER = 'X-Nifty-Date'
    NAMESPACE = 'https://route53.amazonaws.com/doc/2012-12-12/'

    def initialize(access_key, secret_key)
      super(access_key, secret_key)
      @http, @req, @uri = nil
    end

    def get(path)
      init path
      @req = Net::HTTP::Get.new @uri.request_uri
      init_header
      res = call
      Nifcloud::DNS::Response.new(XmlSimple.xml_in(res.body), res.code, res.body)
    end

    def post(path, body)
      init path
      @req = Net::HTTP::Post.new @uri.request_uri
      @req.body = body
      @req.content_type = 'text/xml'
      init_header
      res = call
      Nifcloud::DNS::Response.new(XmlSimple.xml_in(res.body), res.code, res.body)
    end

    def delete(path)
      init path
      @req = Net::HTTP::Delete.new @uri.request_uri
      init_header
      res = call
      Nifcloud::DNS::Response.new(XmlSimple.xml_in(res.body), res.code, res.body)
    end

    private

    def init(path)
      @uri = URI.parse("#{ENDPOINT}#{VERSION}/#{path}")
      @http = Net::HTTP.new(@uri.host, @uri.port)
      @http.use_ssl = true
    end

    def init_header
      @req[AUTHORIZATION_HEADER] = signature_header
      @req[DATE_HEADER] = @time
    end

    def call
      @http.request(@req)
    end
  end
end
