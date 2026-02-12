# frozen_string_literal: true

require 'nifcloud/client'
require 'xmlsimple'

module Nifcloud
  module DNS
    # Class that manages DNS zone information
    class Zone < Client
      HOSTED_ZONE = 'hostedzone'
      HOSTED_ZONE_WITH_ID = 'hostedzone/%s'

      def initialize(access_key: nil, secret_key: nil)
        super(access_key, secret_key)
      end

      def list
        get HOSTED_ZONE
      end

      def show(zone_id)
        get(HOSTED_ZONE_WITH_ID % zone_id)
      end

      def add(zone, comment: '') # rubocop:disable Metrics/MethodLength
        body = {
          '@xmlns': Nifcloud::Client::NAMESPACE,
          Name: [{ content => zone }],
          CallerReference: [{ content => '' }],
          HostedZoneConfig: [{ content => '' }],
          Comment: [{ content => comment }]
        }
        options = {
          AttrPrefix: true,
          RootName: 'CreateHostedZoneRequest',
          ContentKey: 'content'
        }
        post(HOSTED_ZONE, XmlSimple.xml_out(body, options))
      end

      def del(zone_id)
        delete(HOSTED_ZONE_WITH_ID % zone_id)
      end
    end
  end
end
