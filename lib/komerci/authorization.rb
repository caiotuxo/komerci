require "cgi"
require "nokogiri"

module Komerci
  class Authorization

    def self.code(raw_data)
      @code = ret_code(raw_data)
    end

    def self.ret_code(raw_data)

      if !raw_data["NUMCV"].blank? && raw_data["CODRET"].include?("0")
        I18n.t(:authorized, scope: "komerci.errors", default: "cod_ret").to_sym
      else
        I18n.t(:no_authorized, scope: "komerci.errors", default: "cod_ret").to_sym
      end

    end

  end
end
