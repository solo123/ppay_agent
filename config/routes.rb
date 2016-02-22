Rails.application.routes.draw do
  devise_for :users
  # :users必须在devise_for后面定义 bugfix:把user当作资源的话确保路由通过devise验证
  resources :users

  get 'welcome/index'


  resources :logs do
    collection do
      get :get_log_msg
    end
  end
  resources :contracts do
    resources :profit_ladders
  end
  resources :profit_ladders

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

  # 通知
  resources :notices

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
    collection do
      get :current
    end
    member do
      get :basic_info
      get :new_clients
      get :active_clients
      get :active_salesmen
    end
    resources :contracts
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


  root to: 'agents#current'

  # comfy_route :cms_admin, :path => '/cms-admin'
  # comfy_route :cms, :path => '/', :sitemap => false

end
