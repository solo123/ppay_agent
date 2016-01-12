Rails.application.routes.draw do

  resources :nonlogin

  resources :agent_day_tradetotals do
    collection do
      get :active_clients
      get :active_salesmen
    end
  end
  resources :salesman_day_tradetotals
  resources :client_day_tradetotals do
    collection do
      get :month
      get :active
    end
  end

  get 'home/index'
  get 'home/profile'

  # 数据操作
  get 'download/import_xls/:name', to: 'download#import_xls', as: :download_import_xls

  devise_for :users #, controllers: { sessions: "users/sessions" }

  # :users必须在devise_for后面定义 bugfix:把user当作资源的话确保路由通过devise验证
  resources :users

  # 业务数据
  resources :joinlast_clients
  resources :sales_commissions do
    collection do
      get :agents
    end
  end
  resources :bank_cards
  resources :companies
  resources :agents do
    member do
      get :create_login
      get :del_salesman
      get :add_salesman
    end
    resources :contacts
    resources :sales_commissions
  end
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
  resources :code_tables

  root to: 'home#index'

  # comfy_route :cms_admin, :path => '/cms-admin'
  # comfy_route :cms, :path => '/', :sitemap => false

end
