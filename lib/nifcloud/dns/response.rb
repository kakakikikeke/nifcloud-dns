# frozen_string_literal: true

module Nifcloud
  module DNS
    # Class that manages api response information
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
