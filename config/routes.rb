Rails.application.routes.draw do

  devise_for :users

  get 'profile/info'

  get 'home/index'
  get 'home/profile'

  get 'import/do_import'
  get 'import/do_import1'
  get 'import/parse_data'
  get 'import/get_import_msg'
  get 'import/get_log_msg'
  get 'download/import_xls/:name', to: 'download#import_xls', as: :download_import_xls

  # resources :users必须在devise_for后面定义
  resources :users
  resources :agents do
    member do
      post :del_salesman
      post :add_salesman
    end
  end

  # agent data
  resources :clients do
    member do
      post :tags
      get :tags
      post :note
      get :note
    end
  end

  resources :client_notes
  resources :trades
  resources :clearings
  resources :contacts
  resources :addresses
  resources :salesmen
  resources :pos_machines

  # raw data
  resources :imp_ops
  resources :imp_logs
  resources :imp_qf_clearings
  resources :imp_qf_trades
  resources :imp_qf_customers
  resources :data_manage

  root to: 'home#index'

  # comfy_route :cms_admin, :path => '/cms-admin'
  # comfy_route :cms, :path => '/', :sitemap => false

end
