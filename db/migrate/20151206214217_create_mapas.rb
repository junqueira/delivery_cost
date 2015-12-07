class CreateMapas < ActiveRecord::Migration
  def change
    create_table :mapas do |t|
      t.string :nome, null: false

      t.timestamps
    end
    add_index :mapas, :nome , unique: true
  end
end
