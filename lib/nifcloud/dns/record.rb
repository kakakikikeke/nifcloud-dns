require "nifcloud/client"

module Nifcloud
  module DNS
    class Record < Client
      RECORD_SET_WITH_ID = 'hostedzone/%s/rrset'
      RECORD_SET_WITH_PARAMS = 'hostedzone/%s/rrset?%s'

      def initialize(zone_id, access_key: nil, secret_key: nil)
        super(access_key, secret_key)
        @zone_id = zone_id
      end

      def list(options: nil)
        if options.nil? || !options.instance_of?(Hash)
          get(RECORD_SET_WITH_ID % @zone_id)
        else
          get(RECORD_SET_WITH_PARAMS % [@zone_id, options.collect { |k, v| "#{k}=#{CGI::escape(v.to_s)}" }.join('&')])
        end
      end

      def add(name, type, value, ttl: 86400, comment: '')
        post(RECORD_SET_WITH_ID % @zone_id, xml('CREATE', name, type, value, ttl, comment))
      end

      def del(name, type, value, ttl: 86400, comment: '')
        post(RECORD_SET_WITH_ID % @zone_id, xml('DELETE', name, type, value, ttl, comment))
      end

      private

      def xml(action, name, type, value, ttl, comment)
        body = { '@xmlns' => Nifcloud::Client::NAMESPACE,
          'ChangeBatch' => {
            'Comment' => ['content' => comment],
            'Changes' => [
              'Change' => {
                'Action' => ['content' => action],
                'ResourceRecordSet' => {
                  'Name' => ['content' => name],
                  'Type' => ['content' => type],
                  'TTL' => ['content' => ttl],
                  'ResourceRecords' => {
                    'Value' => ['content' => value]
                  }
                }
              }
            ]
          }
        }
        options = {
          'AttrPrefix' => true,
          'RootName' => 'ChangeResourceRecordSetsRequest',
          'ContentKey' => 'content'
        }
        XmlSimple.xml_out(body, options)
      end
    end
  end
end