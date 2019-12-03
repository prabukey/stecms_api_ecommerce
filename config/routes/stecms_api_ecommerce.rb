namespace :stecms_api_ecommerce, path: "backend" do
  resources :categories
  resources :products
  get :sync, controller: "stecms_api_ecommerce/categories", action: :sync
end

namespace :backend do
  mount StecmsApiEcommerce::Engine, at: "/stecms_api_ecommerce", :as => "stecms_api_ecommerce"
end
