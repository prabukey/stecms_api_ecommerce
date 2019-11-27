class CreateStecmsApiEcommerceStoreCategoriesProducts < ActiveRecord::Migration
  def change
    create_table :stecms_api_ecommerce_store_categories_products do |t|

      t.integer :store_product_id
      t.integer :store_category_id

      t.timestamps null: false
    end
  end
end
