module StecmsApiEcommerce
  class StoreCategory < ActiveRecord::Base
    has_and_belongs_to_many :products, class_name: 'StecmsApiEcommerce::StoreProduct'
    belongs_to :category, class_name: 'Category', foreign_key: :content_id
  end
end
