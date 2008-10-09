class StoresController < Spree::BaseController
  
  def index
    @stores = Store.find :all
  end
  
  def show
    @store = Store.find(params[:id])
    self.current_store = @store
    redirect_to products_path
  end
end
