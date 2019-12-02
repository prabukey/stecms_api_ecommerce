
module StecmsApiEcommerce
  class Engine < ::Rails::Engine
    isolate_namespace StecmsApiEcommerce
    #
    # initializer "StecmsApiEcommerce.engine" do |app|
    #   ActionView::Base.send :include, StecmsApiEcommerce::Backend::CategoriesHelper
    # end

    # config.eager_load_paths += Dir["#{StecmsApiEcommerce::Engine.root}/app/models/stecms_api_ecommerce/concerns/"]
    # config.eager_load_paths += Dir["#{StecmsApiEcommerce::Engine.root}/app/helpers/stecms_api_ecommerce/backend/"]
    config.i18n.load_path +=  Dir[StecmsApiEcommerce::Engine.root.join('config', 'locales', 'admin', '**/**/*.{rb,yml}').to_s]

  end
end
