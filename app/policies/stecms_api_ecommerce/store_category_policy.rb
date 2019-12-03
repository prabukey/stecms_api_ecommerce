 module StecmsApiEcommerce
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

    def new?
      category_enabled
    end

    def create?
      category_enabled
    end

    def destroy?
      category_enabled
    end


    private

    def category_enabled
      LipsiaWEB[:modules][:products]
    end


  end

end
