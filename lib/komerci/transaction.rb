require "rest-client"

module Komerci
  class Transaction

    attr_accessor :total_amount ,:installment_quantity , :order_id, :cc_number, :cc_cvv, :cc_month, :cc_year, :cc_holder_name
    attr_reader :transaction, :installments, :response_xml


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
        :AddData => ""
      }

      puts "entrando params"

      puts params

      puts "saindo params"

      response = RestClient.post(uri, params)
      @response_xml = response.to_str
    end

    def installments
      installment_quantity == 1 ? '00' : "0#{installment_quantity}"
    end

    def transaction
      installment_quantity == 1 ? '04' : '08'
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
