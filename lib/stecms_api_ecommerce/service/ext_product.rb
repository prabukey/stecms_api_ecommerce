include StecmsApiEcommerce

module StecmsApiEcommerce
  module Service
    class ExtProduct

      def initialize(args=nil)

        pages = []
        # pages_images = {}
        args.each do |x|
          page = {
            page_layout_identifier: "api_page",
            translations_attributes: [],
            images_attributes: [],
            store_product_attributes: nil
          }

          LipsiaWEB["langs"].each do |lang|
            title = x["name"]
            body  = x["description"]
            if x["translations"].present? && x["translations"][lang.to_s].present?
              title = x["translations"][lang.to_s]["name"]
              body  = x["translations"][lang.to_s]["description"]
            end
            page[:translations_attributes] << {
              locale: lang.to_s,
              title: title,
              body: body,
              active: true
            }
          end

          # pages_images[x["id"]] = []
          x["images"]&.each do |image|
             # pages_images[x["id"]] << {remote_asset_url: ENV["STORE_URL"] + image, active: true}
            page[:images_attributes] << {remote_asset_url: ENV["STORE_URL"] + image, active: true}
          end


          page[:store_product_attributes] = {
            original_id:        x["id"],
            permalink:          x["permalink"],
            price_with_vat:     x["price_with_vat"],
            price_without_vat:  x["price_without_vat"],
            attrs:              x["attributes"],
            categories:         StecmsApiEcommerce::StoreCategory.where(original_id: x["category_ids"])
          }
          pages << page
        end
        @pages = pages
        # @pages_images = pages_images
        @data = args
      end

      def save
        if StecmsApiEcommerce::StoreProduct.first.present?
          create_or_update
        else
          Product.create(@pages)
        end
        # save_images
      end

      def save_images
        @data.each do |p|
          next unless ( images = @pages_images[p["id"]]).present?
          if ( detail = StecmsApiEcommerce::StoreProduct.find_by(original_id: p["id"]) )
            product = detail.product
            product.images.destroy_all if product.images.present?
            images.each do |image|
              begin
                product.images.build(image)
                product.save
              rescue RuntimeError => e
                puts "image not exist"
              end
            end

          end
        end
      end

      def create_or_update
        @pages.each do |prod|
          original_id = prod[:store_product_attributes][:original_id]
          if ( detail = StecmsApiEcommerce::StoreProduct.find_by(original_id: original_id) )
            detail.categories = prod[:store_product_attributes][:categories]
            product = detail.product
            product.images.destroy_all if product.images.present?
            detail.save

            translations = []
            product.translations.each do  |tran|
              tmp = prod[:translations_attributes].select{|x| x[:locale] == tran.locale.to_s}.first
              tmp[:id] = tran.id
              translations << tmp
            end

            prod[:store_product_attributes][:id] = detail.id
            prod[:translations_attributes] = translations
            product.update(prod)
          else
            Product.create(prod)
          end
        end
      end

    end
  end
end
