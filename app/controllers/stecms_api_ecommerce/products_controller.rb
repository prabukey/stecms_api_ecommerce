module StecmsApiEcommerce
  class ProductsController < BackendController

    def index
      authorize(StecmsApiEcommerce::StoreProduct)

      @products = Product.page(params[:page]).per(20)
    end

    def new
      authorize(StecmsApiEcommerce::StoreProduct)

      @product = Product.new
      @product.images.build
      @product.translations.build
      @product.build_store_product
    end

    def create
      authorize(StecmsApiEcommerce::StoreProduct)
      @product = Product.new(params[:product].permit!)
      @product.save
      redirect_to main_app.edit_stecms_api_ecommerce_product_path(@product.id)
    end

    def edit
      @product = Product.find(params[:id])
      authorize(@product.store_product)
    end

    def update
      authorize(StecmsApiEcommerce::StoreProduct)
      @product = StecmsApiEcommerce::StoreProduct.find(params[:id])

      @product.product.update(params[:product].permit!)
      redirect_to main_app.edit_stecms_api_ecommerce_product_path(@product.id)
    end

    def destroy
      authorize(StecmsApiEcommerce::StoreProduct)
      Product.find(params[:id]).destroy

      redirect_to :back
    end
  end
end
