require 'stecms_api_ecommerce/service/ecommerce'
require 'stecms_api_ecommerce/service/ext_product'
require 'stecms_api_ecommerce/service/ext_category'

include StecmsApiEcommerce::Service

module StecmsApiEcommerce

  module Service
    def self.load
      puts "start load categories"
      # categories
      get_data("categories")
      puts "start load products"
      # products
      get_data("products")
    end

    def self.products(responese)
      # responese = get_data("products", p=1)
      product = ::ExtProduct.new(responese["products"])
      product.save
    end

    def self.categories(responese)
      # responese = ::Ecommerce.call  "categories"
      category = ::ExtCategory.new(responese["categories"])
      category.save
    end

    def self.get_data(typ, pg=1)
      responese = ::Ecommerce.call  typ, pg
      typ.eql?("categories") ? categories(responese) : products(responese)

      if responese["total_page"].to_i != pg
        get_data typ, (pg + 1)
      end
    end
  end

end
