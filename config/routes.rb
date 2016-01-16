Rails.application.routes.draw do

  resources :salesman_day_tradetotals

  resource :report do
    collection do
      get :clients_days
      get :active_clients
      get :active_agents
    end
  end

  get 'home/index'
  get 'home/profile'

  # 数据操作
  get 'import/do_import'
  get 'import/do_import1'
  get 'import/parse_data'
  get 'import/get_import_msg'
  get 'import/get_log_msg'
  get 'import/trades_totals'
  get 'download/import_xls/:name', to: 'download#import_xls', as: :download_import_xls

  devise_for :users
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
      get :basic_info
      get :active_clients
      get :active_salesmen
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
