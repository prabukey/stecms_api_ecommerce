  module StecmsApiEcommerce::ApiCategory

    extend ActiveSupport::Concern

    included do
      has_one :store_category,  class_name: "StecmsApiEcommerce::StoreCategory", foreign_key: :content_id
      accepts_nested_attributes_for :translations, :store_category
    end
  end
