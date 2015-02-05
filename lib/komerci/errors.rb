# -*- encoding: utf-8 -*-

module Komerci
  class Errors
    extend Forwardable
    include Enumerable

    def_delegators :@messages, :each, :empty?, :any?, :join, :include?

    def initialize(response)
      @response = response
      @messages = []

      process_response(@response) if response
    end

    private
    def process_response(response)
    arr = ["88", "20","21", "22", "23", "24", "25", "26", "27", "28", "29", "31",
           "32", "33", "34", "35", "36", "37", "38", "39", "40", "41", "42", "43",
           "44", "45", "51", "92", "98", "53", "56", "76", "86", "58", "63", "65",
           "69", "72", "77", "96", "60"]

      raw_data = Hash.from_xml(response.data.to_s.force_encoding('iso-8859-1').encode('utf-8'))
      body = raw_data["AUTHORIZATION"]
      code = body["CODRET"]

      if !Komerci.configuration.environment == :production
        @messages << "ERRO #{code}" if arr.include?(code)
      end

      @messages << error_message(code) if arr.include?(code)

    end

    def response
      @response =response
    end

    def error_message(code)
      I18n.t(code, scope: "komerci.errors", default: "cod_ret")
    end
  end
end
