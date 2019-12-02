  class StoreCategoryPolicy < AdminPolicy

    def index?
      category_enabled
    end

    def edit?
      category_enabled
    end

    def update?
      category_enabled
    end


    def update_password?
      category_enabled
    end


    private

    def category_enabled
      LipsiaWEB[:modules][:products]
    end


  end

