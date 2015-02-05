# -*- encoding: utf-8 -*-

require "cgi"
require "nokogiri"

module Komerci
  class Transaction
    class Response
      extend Forwardable

      def_delegators :response
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
