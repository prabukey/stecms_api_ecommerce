require "stecms_api_ecommerce/engine"
require "stecms_api_ecommerce/service"

module StecmsApiEcommerce
  class ActionDispatch::Routing::Mapper
    def stecme_api_ecommerce
      instance_eval(File.read(StecmsApiEcommerce::Engine.root.join("config/routes/stecms_api_ecommerce.rb")))
    end
  end

  def self.url_helpers
    ::Engine.routes.url_helpers
  end
end
