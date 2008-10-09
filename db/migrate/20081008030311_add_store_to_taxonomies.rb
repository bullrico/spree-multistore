class AddStoreToTaxonomies < ActiveRecord::Migration
  def self.up
    add_column :taxonomies, :store_id, :integer
  end

  def self.down
    remove_column :taxonomies, :store_id

  end
end
