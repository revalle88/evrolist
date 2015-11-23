List::Application.routes.draw do
  get "test/createorder"
  get "order_items/create"
  get "order_items/update"
  get "order_items/destroy"
  get "carts/show"
  get "favourites/addToFavourites"
  get "favourites/showFavourites"
  root 'catalog#root'
  devise_for :users, controllers: {registrations: "registrations"}
  get "myxml/parseGoods"
  get "myxml/loadGoods"
  get "myxml/loadProductImages"
  get "myxml/parseXMLcats"
  get "myxml/loadCategories"
  get "myxml/updatePrices"
  get "favourites/deleteSession"
  get "favourites/destroy"
  resources :properties

  get "test/clearSession"

  resource :cart, only: [:show]
  resources :order_items, only: [:create, :update, :destroy]

  get "test/createorder"

  

  get "catalog/root"
  get "catalog/addProp"
  get 'catalog/show/:cat_id', to: 'catalog#show', as: 'show_products_in_cat'
  get 'catalog/product/:good_id', to: 'catalog#product', as: 'show_good_page'
  resources :products

  resources :categories

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end
  
  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end