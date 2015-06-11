# -*- encoding: utf-8 -*-

require "rest-client"
require "aitch"

module Komerci
  class Transaction

    attr_accessor :response
    attr_accessor :total_amount ,:installment_quantity , :order_id, :cc_number, :cc_cvv, :cc_month, :cc_year, :cc_holder_name,  :transaction
    attr_reader  :installments, :response_xml

    def send
      uri = Komerci.uris[self.class.to_s.demodulize.to_s.downcase]
      params = {
        :Total => "%.2f" % total_amount,
        :Transacao => transaction,
        :Parcelas => installments,
        :Filiacao => Komerci.configuration.filiation,
        :NumPedido => order_id,
        :Nrcartao => cc_number,
        :CVC2 => cc_cvv,
        :Mes => cc_month,
        :Ano => cc_year,
        :Portador => cc_holder_name,

        :IATA => "",
        :Distribuidor => "",
        :Concentrador => "",
        :TaxaEmbarque => "",
        :Entrada => "",
        :Pax1 => "",
        :Pax2 => "",
        :Pax3 => "",
        :Pax4 => "",
        :Numdoc1 => "",
        :Numdoc2 => "",
        :Numdoc3 => "",
        :Numdoc4 => "",
        :ConfTxn => ("S"),
        :AddData => "",
        "Add_Data" => ""
      }

      resp = Aitch.post(uri, params, {} ,{})

      response = Response.new (resp)

    end

    def installments
      installment_quantity.to_s.include?('1') ? '00' : "0#{installment_quantity}"
    end

    def transaction
      installment_quantity.to_s.include?('1') ? '04' : '08'
    end

    def response
      @response = response
    end

  end

  class PreAuthorization < Transaction
    def transaction=(value)
      raise InvalidTransaction, value unless value == :pre_autorizacao
    end

    def transaction
      :pre_autorizacao
    end

    def installments=(value)
      raise InvalidTransaction, value unless value == ""
    end

    def installments
      ""
    end

    def auto_confirm=(value)
      raise InvalidTransaction, value unless value == true
    end

    def auto_confirm
      true
    end
  end
end
