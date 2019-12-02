# require_dependency "stecms_api_ecommerce/application_controller"

module StecmsApiEcommerce
  class CategoriesController < BackendController

    def index
      @categories = StecmsApiEcommerce::StoreCategory.page(params[:page]).per(5)
      authorize(@categories)
    end

    def new
    end

    def edit
      @category = Product::Category.find(params[:id])
      authorize(@category.store_category)
    end

    def update
      @category = StecmsApiEcommerce::StoreCategory.find(params[:id])
      authorize(@category)

      @category.category.update(params[:product_category].permit!)
      redirect_to main_app.edit_stecms_api_ecommerce_category_path(@category.category.id)
    end
  end
end
