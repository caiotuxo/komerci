# -*- encoding: utf-8 -*-

require "rest-client"

module Komerci
  class ConfirmPreAuthorization

    attr_accessor :total, :installments, :date, :filiation_number, :authorization, :confirmation, :user, :password

    def send
      uri = Komerci.uris[self.class.to_s.demodulize.to_s.downcase]
      params = {
        :Total    => "%.2f" % total,
        :Parcelas => "%02d" % installments,
        :data     => date,
        :Filiacao => filiation_number,
        :NumAutor => authorization,
        :NumCV    => confirmation,
        :Usr      => user,
        :Pwd      => password,

        :Distribuidor => "",
        :Concentrador => ""
      }

      response = RestClient.post(uri, params)
      Authorization.from_xml(response)
    end
  end
end
