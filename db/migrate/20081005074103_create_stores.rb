class CreateStores < ActiveRecord::Migration
  def self.up
    create_table :stores do |t|
      t.string :name, :host
      t.timestamps
    end
    add_column :products, :store_id, :integer
    add_column :users, :store_id, :integer
  end

  def self.down
    remove_column :users, :store_id
    remove_column :products, :store_id
    drop_table :stores
  end
end
