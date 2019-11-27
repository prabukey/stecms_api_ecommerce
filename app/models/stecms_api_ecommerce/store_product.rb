module StecmsApiEcommerce
  class StoreProduct < ActiveRecord::Base
    has_and_belongs_to_many :categories, class_name: 'StecmsApiEcommerce::StoreCategory'
    belongs_to :product, class_name: 'Product', foreign_key: :content_id
  end
end
