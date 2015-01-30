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
      raw_data = Hash.from_xml(response.data.to_s.force_encoding('iso-8859-1').encode('utf-8'))
      body = raw_data["AUTHORIZATION"]

      @messages << error_message("88") if body["CODRET"].include?("88")

    end
    def response
      @response =response
    end

    def error_message(code)
      I18n.t(code, scope: "komerci.errors", default: "cod_ret")
    end
  end
end
