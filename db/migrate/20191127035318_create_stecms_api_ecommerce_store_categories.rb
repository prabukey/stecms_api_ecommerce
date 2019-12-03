class CreateStecmsApiEcommerceStoreCategories < ActiveRecord::Migration
  def change
    create_table :stecms_api_ecommerce_store_categories do |t|

      t.integer :original_id
      t.integer :content_id
      t.string  :permalink

      t.timestamps null: false
    end
  end
end
