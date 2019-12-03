include StecmsApiEcommerce

module StecmsApiEcommerce
  module Service
    class ExtProduct

      def initialize(args=nil)
        # detail_products = args.map do |x|
        #   {
        #     original_id:        x["id"],
        #     permalink:          x["permalink"],
        #     price_with_vat:     x["price_with_vat"],
        #     price_without_vat:  x["price_without_vat"],
        #     categories:         StecmsApiEcommerce::StoreCategory.select(:id).where(original_id: x["category_ids"])
        #   }
        # end
        # @detail_products = detail_products


        pages = []

        args.each do |x|
          page = {
            page_layout_identifier: "api_page",
            translations_attributes: [],
            images_attributes: [],
            store_product_attributes: nil
          }

          LipsiaWEB["langs"].each do |lang|
            if x["translations"].present? && x["translations"][lang.to_s].present?
              title = x["translations"][lang.to_s]["text"]
              body  = x["translations"][lang.to_s]["description"]
            end
            page[:translations_attributes] << {
              locale: lang.to_s,
              title: title,
              body: body,
              active: true
            }
          end

          x["images"]&.each do |image|
            page[:images_attributes] << {remote_asset_url: ENV["STORE_URL"] + image, active: true}
          end

          page[:store_product_attributes] = {
            original_id:        x["id"],
            permalink:          x["permalink"],
            price_with_vat:     x["price_with_vat"],
            price_without_vat:  x["price_without_vat"],
            categories:         StecmsApiEcommerce::StoreCategory.select(:id).where(original_id: x["category_ids"])
          }
          pages << page
        end
        @pages = pages
      end

      def save
        if StecmsApiEcommerce::StoreProduct.first.present?
          create_or_update
        else
          Product.create(@pages)
        end
      end

      def create_or_update(pages)
        pages.each do |prod|
          original_id = prod[:store_product_attributes][:original_id]
          if ( detail = StecmsApiEcommerce::StoreProduct.find_by(original_id: original_id) )
            prod[:store_product_attributes].keys.each { |key| detail[:store_product_attributes][key.to_sym] = prod[key] if key != :categories}
            detail.categories = prod[:store_product_attributes][:categories]
            product = detail.product
            product.images.destroy_all
            detail.save

            translations = []
            product.translations.each do  |tran|
              tmp = page[:translations_attributes].select{|x| x[:locale] == tran.locale}.first
              tmp[:id] = tran.id
              translations << tmp
            end

            page[:store_product_attributes][:id] = detail.id
            page[:translations_attributes] = translations
            product.update(page)
          else
            Product.create(prod)
          end
        end
      end

    end
  end
end
