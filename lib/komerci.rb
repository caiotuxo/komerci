require "komerci/version"

module Komerci
  autoload :Transaction, "komerci/transaction"
  autoload :CouncilReport, "komerci/council_report"
  autoload :Authorization, "komerci/authorization"

  class << self
    attr_accessor :configuration
  end

  def self.configure
    self.configuration ||= Configuration.new
    yield(configuration)
  end

  class Configuration
    attr_accessor :filiation

    def initialize
      @filiation = 'filiation'
    end
  end

end
