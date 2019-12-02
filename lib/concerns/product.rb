module StecmsApiEcommerce
  module Product

    extend ActiveSupport::Concern

    included do

      has_one :store_product,  class_name: "StecmsApiEcommerce::StoreProduct", foreign_key: :content_id
      accepts_nested_attributes_for :translations, :store_product
      has_and_belongs_to_many :store_categories, join_table: "stecms_api_ecommerce_store_categories_products", class_name: 'StecmsApiEcommerce::StoreCategory', through: :store_product, foreign_key: :store_product_id


      def categories
        ids = store_categories.select(:content_id).map(&:content_id)
        Product::Category.find(ids)
      end

    end
  end
end
