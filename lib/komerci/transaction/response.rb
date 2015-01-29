require "cgi"
require "nokogiri"

module Komerci
  class Transaction
    class Response
      extend Forwardable

      attr_accessor :response

      def initialize(response)
        @response =  response
      end

      def errors
        @errors ||= Errors.new(response)
      end

    end

  end
end
