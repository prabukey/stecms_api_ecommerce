include StecmsApiEcommerce

module StecmsApiEcommerce
  module Service
    class ExtProduct

      def initialize(args=nil)
        detail_products = args.map do |x|
          {
            original_id:        x["id"],
            permalink:          x["permalink"],
            price_with_vat:     x["price_with_vat"],
            price_without_vat:  x["price_without_vat"],
            categories:         StecmsApiEcommerce::StoreCategory.select(:id).where(original_id: x["category_ids"])
          }
        end
        @detail_products = detail_products
      end

      def save
        if StecmsApiEcommerce::StoreProduct.first.present?
          create_or_update
        else
          StecmsApiEcommerce::StoreProduct.create @detail_products
        end
      end

      def create_or_update
        @detail_products.each do |prod|
          if ( detail = StecmsApiEcommerce::StoreProduct.find_by(original_id: prod[:original_id]) )
            prod.keys.each { |key| detail[key.to_sym] = prod[key] if key != :categories}
            detail.categories = prod[:categories]
            detail.save
          else
            StecmsApiEcommerce::StoreProduct.create(prod)
          end
        end
      end

    end
  end
end
