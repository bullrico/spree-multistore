class StoresController < Spree::BaseController
  
  def index
    @stores = Store.find :all
  end
  
  def show
    @store = current_store
  end
end
