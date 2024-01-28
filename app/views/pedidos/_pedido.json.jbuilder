if pedido
  json.num_pedido pedido.num_pedido
  json.status pedido.status
  json.itens do
    json.array! pedido.itens do |item|
      json.partial! "pedidos/item", pedido: pedido, item: item
    end
  end
else
  json.null
end
