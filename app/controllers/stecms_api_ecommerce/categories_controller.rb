# require_dependency "stecms_api_ecommerce/application_controller"

module StecmsApiEcommerce
  class CategoriesController < BackendController

    def index
      @categories = StecmsApiEcommerce::StoreCategory.page(10)
      authorize(@categories)
    end
  end
end
