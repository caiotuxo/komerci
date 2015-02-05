# Biblioteca de integração Komerci em Ruby (Redecard)

## Descrição

A biblioteca Komerci em Ruby é um conjunto de classes de domínio que facilitam, para o desenvolvedor Ruby, a utilização das funcionalidades que a Redecard oferece na forma de APIs. Com a biblioteca instalada e configurada, você pode facilmente integrar funcionalidades como:

 - Criar [transações em um passo]
 - Criar [transações em dois passos]
 - Consultar [transações por intervalo de datas]

## Instalação

 - Adicione a biblioteca ao seu Gemfile.

```ruby
    gem 'komerci', github: 'railainesantos/komerci', branch: 'master'
```

 - Execute o comando `bundle install`.

```ruby
    $ bundle install
```

## Configuração

Para fazer a autenticação, você precisará configurar as credenciais na Redecard. Crie o arquivo `config/initializers/komerci.rb` com o conteúdo abaixo.

```ruby
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

```
Os parâmetros filiation, user e pwd estão disponíveis em (https://www.userede.com.br).


## Pagamentos

Para iniciar uma requisição de pagamento em um passo só, você precisa instanciar a classe `Komerci::Transaction.new`. Isso normalmente será feito em seu controller de checkout.

```ruby
  def process

      payment = Komerci::Transaction.new

      payment.total_amount = transaction.total_amount
      payment.installment_quantity = transaction.installment_quantity
      payment.order_id = transaction.order_id
      payment.cc_number = transaction.cc_number
      payment.cc_cvv = transaction.cc_cvv
      payment.cc_month = transaction.cc_month
      payment.cc_year = transaction.cc_year
      payment.cc_holder_name = transaction.cc_holder_name

      xml = payment.send
  end

```

## Contribuições

Achou e corrigiu um bug ou tem alguma feature em mente e deseja contribuir?

* Faça um fork.
* Adicione sua feature ou correção de bug.
* Envie um pull request no [GitHub].

  [documentação do komerci]: https://www.userede.com.br/pt-BR/Lists/Downloads/Attachments/12/2409_Manual%20Komerci%20Webservice.pdf
