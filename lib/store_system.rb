module StoreSystem
  protected
  
    def current_store
      @current_store ||= Store.find_by_host(request.host) or raise Store::UndefinedError
    end
 
 end
