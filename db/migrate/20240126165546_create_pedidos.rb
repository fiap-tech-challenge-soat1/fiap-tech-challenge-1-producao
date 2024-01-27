class CreatePedidos < ActiveRecord::Migration[7.1]
  def change
    create_table :pedidos do |t|
      t.integer :num_pedido
      t.integer :status

      t.timestamps
    end
  end
end
