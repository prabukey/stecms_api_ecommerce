class CreateStecmsApiEcommerceStoreProducts < ActiveRecord::Migration
  def change
    create_table :stecms_api_ecommerce_store_products do |t|
      t.integer :original_id
      t.string  :permalink
      t.float   :price_with_vat
      t.float   :price_without_vat
      t.integer :content_id

      t.timestamps null: false
    end
  end
end
