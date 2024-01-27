class AddUniquenessIndexToPedido < ActiveRecord::Migration[7.1]
  def change
    add_index :pedidos, :num_pedido, unique: true
  end
end
