module Nifcloud
  module DNS
    class Response
      def initialize(body, code, raw)
        @body = body
        @code = code
        @raw = raw
      end

      attr_reader :body, :code, :raw
    end
  end
end
