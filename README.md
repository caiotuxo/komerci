# Biblioteca de integração Komerci em Ruby (Redecard)

## Descrição

A biblioteca Komerci em Ruby é um conjunto de classes de domínio que facilitam, para o desenvolvedor Ruby, a utilização das funcionalidades que a Redecard oferece na forma de APIs. Com a biblioteca instalada e configurada, você pode facilmente integrar funcionalidades como:

 - Criar [transações em um passo]
 - Criar [transações em dois passos]
 - Consultar [transações por intervalo de datas]

## Instalação

 - Adicione a biblioteca ao seu Gemfile.

    gem 'komerci', github: 'railainesantos/komerci', branck: 'master'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install komerci

Add an initializer file to 'config/initializers' with:

    # encoding: utf-8
    require 'komerci'

    Komerci.configure do |config|
      if Rails.env.development?
        config.filiation = '123456789'
        config.environment = :development
        #config.user = 'cadastrar'
        #config.pwd = "cadastrar"
      elsif Rails.env.staging?
        config.filiation = '123456789'
        config.environment = :test
        #config.user = 'cadastrar'
        #config.pwd = "cadastrar"
      else
        config.filiation = '123456789'
        config.environment = :production
        #config.user = 'cadastrar'
        #config.pwd = "cadastrar"
      end
    end

## Usage

TODO: Write usage instructions here

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
