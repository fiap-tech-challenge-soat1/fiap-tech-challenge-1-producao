json.array! @pedidos do |pedido|
  json.partial! "pedidos/pedido", pedido: pedido
end
