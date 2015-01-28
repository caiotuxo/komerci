require "rest-client"

module Komerci
  class Transaction

    attr_accessor :total_amount ,:installment_quantity , :order_id, :cc_number, :cc_cvv, :cc_month, :cc_year, :cc_holder_name
    attr_reader :transaction, :installments, :response_xml


    def send
      uri = "https://ecommerce.redecard.com.br/pos_virtual/wskomerci/cap.asmx/GetAuthorized"

      params = {
        :Total => "%.2f" % total_amount,
        :Transacao => transaction,
        :Parcelas => "%02d" % installments.to_i,
        :Filiacao => Komerci.filiation,
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
        :Add_Data => ""
      }

      #response = RestClient.post(uri, params)
      #@response_xml = response.to_str
      #Authorization.from_xml(response)

      puts "Entrando aqui"
      puts params

      puts "Saindo aqui"
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
