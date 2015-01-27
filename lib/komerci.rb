require "komerci/version"

module Komerci
  puts "Entrando module"
  autoload :Transaction, "komerci/transaction"
  autoload :CouncilReport, "komerci/council_report"
  autoload :Authorization, "komerci/authorization"
  puts "Saindo module"
end
