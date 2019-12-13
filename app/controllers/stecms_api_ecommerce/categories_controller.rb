module StecmsApiEcommerce
  class CategoriesController < BackendController

    def index
      authorize(StecmsApiEcommerce::StoreCategory)
      @categories = Product::Category.page(params[:page]).per(20)
    end

    def new
      authorize(StecmsApiEcommerce::StoreCategory)

      @category = Product::Category.new
      @category.images.build
      @category.translations.build
      @category.build_store_category
    end

    def create
      authorize StecmsApiEcommerce::StoreCategory
      @category = Product::Category.new(params[:product_category].permit!)
      @category.save
      redirect_to main_app.edit_stecms_api_ecommerce_category_path(@category.id)
    end

    def edit
      authorize(StecmsApiEcommerce::StoreCategory)
      @category = Product::Category.find(params[:id])
    end

    def update
      authorize(StecmsApiEcommerce::StoreCategory)
      @category = Product::Category.find(params[:id])

      @category.update(params[:product_category].permit!)
      redirect_to main_app.edit_stecms_api_ecommerce_category_path(@category.id)
    end

    def destroy
      authorize(StecmsApiEcommerce::StoreCategory)
      Product::Category.find(params[:id]).destroy

      redirect_to :back
    end

    def sync
      authorize(StecmsApiEcommerce::StoreCategory)
      StecmsApiEcommerce::Service.load
      redirect_to :back
    end
  end
end
