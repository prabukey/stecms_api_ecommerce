module StecmsApiEcommerce
  class StoreCategory < ActiveRecord::Base
    self.table_name = "stecms_api_ecommerce_store_categories"
    has_and_belongs_to_many :products, class_name: 'StecmsApiEcommerce::StoreProduct'
    belongs_to :category, class_name: 'Product::Category', foreign_key: :content_id
  end
end
