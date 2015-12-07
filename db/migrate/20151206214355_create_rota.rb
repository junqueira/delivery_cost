class CreateRota < ActiveRecord::Migration
  def change
    create_table :rota do |t|
      t.references :mapa, index: true
      t.string :origem, null: false
      t.string :destino, null: false
      t.float :distancia, null: false

      t.timestamps
    end
    add_index :rota, [:origem, :destino], unique: true
  end
end
