require "komerci/version"

module Komerci
  autoload :Transaction, "komerci/transaction"
  autoload :CouncilReport, "komerci/council_report"
  autoload :Authorization, "komerci/authorization"

  class << self
    attr_accessor :configuration
  end

  def self.uris
    case Komerci.configuration.environment
    when :development
      @uris = { 'transaction' => "https://ecommerce.userede.com.br/pos_virtual/wskomerci/cap_teste.asmx/GetAuthorizedTst" ,
                'council_report' => "https://ecommerce.userede.com.br/pos_virtual/wskomerci/cap_teste.asmx/CouncilReportTst" ,
                'confirm_pre_authorization' => "https://ecommerce.userede.com.br/pos_virtual/wskomerci/cap_teste.asmx/ConfPreAuthorizationTst" ,
                'confirm_transaction' => "https://ecommerce.userede.com.br/pos_virtual/wskomerci/cap_teste.asmx/ConfirmTxnTst" }
    when :test
      @uris = { 'transaction' => "https://ecommerce.userede.com.br/pos_virtual/wskomerci/cap_teste.asmx/GetAuthorizedTst" ,
                'council_report'=> "https://ecommerce.userede.com.br/pos_virtual/wskomerci/cap_teste.asmx/CouncilReportTst" ,
                'confirm_pre_authorization'=> "https://ecommerce.userede.com.br/pos_virtual/wskomerci/cap_teste.asmx/ConfPreAuthorizationTst",
                'confirm_transaction' => "https://ecommerce.userede.com.br/pos_virtual/wskomerci/cap_teste.asmx/ConfirmTxnTst" }

    when :production
      @uris = { 'transaction' => "https://ecommerce.redecard.com.br/pos_virtual/wskomerci/cap.asmx/GetAuthorized" ,
                'council_report' => "https://ecommerce.redecard.com.br/pos_virtual/wskomerci/cap.asmx/CouncilReport" ,
                'confirm_pre_authorization' => "https://ecommerce.userede.com.br/pos_virtual/wskomerci/cap.asmx/ConfPreAuthorization" ,
                'confirm_transaction' => "https://ecommerce.userede.com.br/pos_virtual/wskomerci/cap.asmx/ConfirmTxn" }

    end
  end

  def self.configure
    self.configuration ||= Configuration.new
    yield(configuration)
  end

  class Configuration
    attr_accessor :filiation
    attr_accessor :environment

    def initialize
      @filiation = 'filiation'
      @environment = :production
    end
  end

end
