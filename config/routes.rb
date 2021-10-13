Rails.application.routes.draw do

  # get 'user/index'
  # get 'user/show'
  # get 'user/new'
  # get 'user/create'
  # get 'user/edit'
  # get 'user/update'
  # get 'user/delete'
  apipie
  controller :product do
    #get 'product/index' => :index, as: 'product_index'
    post 'create_product' => :new, as: 'product_create'
    get '/product/:id' => :show, as: 'product_show'
    put 'update/:id' => :edit, as: 'product_update'
    delete 'delete/:id' => :delete, as: 'destroy_product'
  end

  controller :user do
    get 'users' => :index, as: 'user_index'
    post 'create_user' => :create, as: 'create_user'
    get '/user/:id' => :show, as: 'show_user'
    put 'update_user/:id' => :edit, as: 'update_user'
    delete 'delete_user/:id' => :delete, as: 'delete_user'
  end
  # get 'product/create'
  # get 'product/update'
  # get 'product/delete'
  #get 
  #get 'home/index'
  root 'product#index'
  devise_for :users
  resources :products, controller: 'product'
  resources :users, controller: 'user', except: :create
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
