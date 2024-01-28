class CreateItems < ActiveRecord::Migration[7.1]
  def change
    create_table :items do |t|
      t.references :pedido, null: false, foreign_key: true
      t.string :nome
      t.text :observacao
      t.integer :quantidade

      t.timestamps
    end
  end
end
