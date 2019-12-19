class AddFieldAttributesOnStecmsApiEcommerceStoreProducts < ActiveRecord::Migration
  def change
    add_column :stecms_api_ecommerce_store_products, :attrs, :text
  end
end
