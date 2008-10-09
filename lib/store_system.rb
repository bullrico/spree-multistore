module MultiStore
  module StoreSystem
    
    def current_store
      @current_store ||= (get_store_from_request || get_store_from_session || false)
    end
    
    def current_store=(new_store)
      session[:store_id] = new_store.nil? ? nil : new_store.id
      @current_store = new_store || :false
    end
    
    def get_store_from_session
      self.current_store = Store.find(session[:store_id]) if session[:store_id]
    end

    def get_store_from_request
      self.current_store = Store.find_by_param(params[:store_name])
    end
     
    def get_store_and_products
      yield
      # raise Store::UndefinedError unless @store = current_store
      @store = current_store
      @taxonomies = @store.taxonomies.find(:all, :include => {:root => :children})
      @products = @store.products.find(:all)
    end
    
    def get_store_for_owner
      @store = current_user.store if current_user.has_role?("admin")
      self.current_store = @store
    end

    def get_store_products
      @products = @store.products
    end
  end
end