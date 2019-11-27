module StecmsApiEcommerce
  module Service
    class ExtCategory

      def initialize(args=nil)
        @pages = []

        @categories = args.map{|x| {original_id: x["id"]}}
        @langs = LipsiaWEB["langs"]
        @translations = {}
        args.each do |x|
          page = {page_layout_identifier: "api_page", translations: [], store_category: nil}
          translations[x.id.to_s] = { translations: [] }

          LipsiaWEB["langs"].each do |lang|
            title = x["text"]
            body  = x["description"]
            if x["translations"].present? && x["translations"][lang.to_s].present
              title = x["translations"][lang.to_s]["text"]
              body  = x["translations"][lang.to_s]["description"]
            end
            page[:translations] << {
              locale: lang.to_s,
              title: title,
              body: body
            }
          end

          page[:store_category] = x["id"]
        end
      end

       def save
        if StecmsApiEcommerce::StoreCategory.first.present?
          create_or_update
        else
          set_category_page
          # StecmsApiEcommerce::StoreCategory.create @categories
        end
      end

      def create_or_update
        # @categories.each do |prod|
        #   if ( detail = StecmsApiEcommerce::StoreCategory.find_by(original_id: prod[:original_id]) )
        #     detail.update(prod)
        #   else
        #     StecmsApiEcommerce::StoreCategory.create(prod)
        #   end
        # end

        @pages.each do |page|
          original_id = page[:store_category][:original_id]
          if ( detail = StecmsApiEcommerce::StoreCategory.find_by(original_id: original_id) )
            category = detail.category

            category.update(page)

          else
            Product::Category.create(page)
          end
        end
      end

      def set_category_page(data)
        Product::Category.create(@pages)
      end

    end
  end
end
