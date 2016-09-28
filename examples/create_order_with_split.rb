require 'moip_api'
require 'pry'
require_relative './configuration'

@amount = Moip::Resource::Amount.new(currency: "BRL", subtotals: {shipping: 50})

@receiver = Moip::Resource::Receiver.new(type: "SECONDARY", moipAccount: {}, amount: {})

@item = Moip::Resource::Item.new(detail: "Product 1", quantity: 2, price: 2000, product: "Description of a product...")

@address = Moip::Resource::Address.new(city: "São Paulo", complement: "8", street: "Avenida Faria Lima", streetNumber: "2927", zipCode: "0123400000", state: "SP", type: "SHIPPING", country: "BRA")

@order = Moip::Resource::Order.new(own_id: "0001", amount: @amount, receivers: [@receiver], items: [@item], customer: 201)

@api = Moip::Api.new

@body ={
  "ownId": "seu_identificador_proprio",
  "amount": {
    "currency": "BRL",
    "subtotals": {
      "shipping": 1000
    }
  },
  "items": [
    {
      "product": "Descrição do pedido",
      "quantity": 1,
      "detail": "Mais info...",
      "price": 1000
    }
  ],
  "customer": {
    "ownId": "cliente_xyz",
    "fullname": "João Silva",
    "email": "joaosilva@email.com"
  }
} 

# @response = @api.order.create(@body.to_json)
@headers = {:"Content-Type"=>"application/json", :Authorization=>"Basic WUpORzJKSjdFRjlEMDRET01UR0U4VDZaQzJUQ1pBQ0Q6TDRCSDY3T0VPUFg4TDhLS0g5SFRUU1dNQ0ZaSDVIMkJZUzE4Rk9VSw=="} 
@response = @api.order.client.class.post("/orders", body: @body.to_json, headers: @headers)

# @response = @api.account.client.class.post "/orders", headers: @headers,  body: @body.to_json

# @api.order.client.uri = "http://sandbox.moip.com.br/v2"
# @reponse = @api.order.client.post("/orders", @body.to_json)

binding.pry