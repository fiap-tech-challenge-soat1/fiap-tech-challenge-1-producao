module PedidosApi
  class Client
    include HTTParty

    base_uri(ENV["PEDIDOS_API_URL"] || "api.pedidos.com")

    def notificar(pedido)
      self.class.post("/pedidos/#{pedido}/finalizar")
    end
  end
end
