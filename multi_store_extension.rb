# Uncomment this if you reference any of your controllers in activate
require_dependency 'application'

class MultiStoreExtension < Spree::Extension
  version "1.0"
  description "Adds multistore functionality"
  url "http://yourwebsite.com/my_store"

  define_routes do |map|
    map.resources :stores    
    map.connect '/:store_name', :controller => 'products', :action => 'index', :id => :store_name
  end
  
  def activate
    
    User.class_eval do
      belongs_to :store      
    end
    
    Product.class_eval do
      belongs_to :store
    end
    
    Taxonomy.class_eval do
      belongs_to :store
    end
    
    ApplicationController.class_eval do
      include MultiStore::StoreSystem

      def instantiate_controller_and_action_names
        @current_action = action_name
        @current_controller = controller_name
      end
    end

    ProductsController.class_eval do    
      around_filter :get_store_and_products
      
      # rescue_from Store::UndefinedError do |exception|
      #   redirect_to stores_path
      # end
      
    end
    
    UsersController.class_eval do
      before_filter :add_store_fields, :only => :new
            
      def add_store_fields
        @extension_partials << 'store'
      end

      def create
        @user = User.new(params[:user])
        @store = @user.build_store(params[:store])
        respond_to do |format|  
          if @user.save
            # create an admin role and and assign the admin user to that role
            @user.roles << Role.find_by_name('admin')
            self.current_store = @store
            format.html { redirect_to products_path}        
          else
            format.html { render :action => "new" }
          end 
        end
      end
    end
    
    Admin::BaseController.class_eval do
      before_filter :get_store_for_owner
    end
    
    Admin::ProductsController.class_eval do
      before_filter :get_store_products
    end
    
  end
  
  def deactivate
    # admin.tabs.remove "Look And Feel"
  end
  
end