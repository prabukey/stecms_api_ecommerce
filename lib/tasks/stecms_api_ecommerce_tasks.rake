namespace :stecms_api_ecommerce do
  desc "run copy templates backend_menu"
  task :menu_admin do
    file = StecmsApiEcommerce::Engine.root.join("lib/templates/_backend_menu.haml")
    target = Rails.root.join("app/views/backend/_backend_menu.haml")
    system("cp #{file} #{target}")
    puts "copy templates #{target}"
  end
end
