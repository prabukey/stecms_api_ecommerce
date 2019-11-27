require 'stecms_api_ecommerce/service/ecommerce'
require 'stecms_api_ecommerce/service/ext_product'
require 'stecms_api_ecommerce/service/ext_category'

include StecmsApiEcommerce::Service

module StecmsApiEcommerce

  module Service
    def self.products
      puts "run"
      responese = ::Ecommerce.call  "products"
      product = ::ExtProduct.new(responese["products"])
      product.save
    end

    def self.categories
      responese = ::Ecommerce.call  "categories"
      category = ::ExtCategory.new(responese["categories"])
      category.save
    end
  end

end
