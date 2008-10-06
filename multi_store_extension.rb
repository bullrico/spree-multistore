# Uncomment this if you reference any of your controllers in activate
require_dependency 'application'

class MultiStoreExtension < Spree::Extension
  version "1.0"
  description "Implements multistore functionality"
  url "http://yourwebsite.com/stores"

  define_routes do |map|
    # map.namespace :admin do |admin|
    #   admin.resources :whatever
    # end 
    # map.root :controller => "stores", :action => "index"
    map.resources :stores 
  end
  
  def activate
    
    ApplicationController.class_eval do
      include StoreSystem
    end

    ProductsController.class_eval do      
      before_filter :get_store_and_products, :only => :index
      before_filter :get_store_and_product, :only => :show

      def get_store_and_products
        @store = current_store
        @products = @store.products
      end
  
      def get_store_and_product
        @store = current_store
        @product = @store.product.find(params[:id])
      end
      
     end
 
    Product.class_eval do
      belongs_to :store
    end
    
    UsersController.class_eval do
      before_filter :add_store_fields, :only => :new
      before_filter  :add_store, :only => [ :create ]
      
      def add_store
        store = @user.store.build(params[:store])
      end
      
      def add_store_fields
        @extension_partials << 'store'
      end
    end
    
    User.class_eval do
      belongs_to :store      
    end

  end
  
  def deactivate
    # admin.tabs.remove "Look And Feel"
  end
  
end