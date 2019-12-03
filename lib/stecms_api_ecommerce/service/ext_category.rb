module StecmsApiEcommerce
  module Service
    class ExtCategory

      def initialize(args=nil)
        pages = []
        puts "load categories #{args.present?}"
        args.each do |x|
          page = {
            page_layout_identifier: "api_page",
            translations_attributes: [],
            images_attributes: [],
            store_category_attributes: nil}

          LipsiaWEB["langs"].each do |lang|
            title = x["text"]
            body  = x["description"]
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

          page[:store_category_attributes] = {
            original_id: x["id"],
            permalink: x["permalink"]
          }

          pages << page
        end
        @pages = pages
      end

       def save
        if StecmsApiEcommerce::StoreCategory.first.present?
          create_or_update
        else
          Product::Category.create(@pages)
        end
      end

      def create_or_update
        @pages.each do |page|
          original_id = page[:store_category_attributes][:original_id]
          if ( detail = StecmsApiEcommerce::StoreCategory.find_by(original_id: original_id) )
            category = detail.category
            category.images.destroy_all

            page[:store_category_attributes][:id] = detail.id

            translations = []
            category.translations.each do  |tran|
              tmp = page[:translations_attributes].select{|x| x[:locale] == tran.locale.to_s}.first
              tmp[:id] = tran.id
              translations << tmp
            end
            page[:translations_attributes] = translations

            category.update(page)
          else
            Product::Category.create(page)
          end
        end
      end

    end
  end
end
