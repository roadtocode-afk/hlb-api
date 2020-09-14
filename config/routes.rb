Rails.application.routes.draw do
  root to: 'welcome#index'
  devise_for :users,
             path: '',
             path_names: {
               sign_in: 'login',
               sign_out: 'logout',
               registration: 'signup'
             },
               controllers: {
                 sessions: 'sessions'
              }

  resources :product_deals
  resources :user_comments, only: [:create, :index, :destroy]
  get "/popular_product_deals", to: "product_deals#popular_product_deals"
  get "/favorite_product_deals", to: "product_deals#favorite_product_deals"
  get "/filter_deals", to: "product_deals#filter_deals"
  get "/new_prod_deals", to: "product_deals#new_product_deals"
  get "/favorite_product_deals/:product_deal_id", to: "favorite_product_deals#user_fav_prod_deal"
  get "/user_favorite_product_deals", to: "favorite_product_deals#user_fav_prod_deals"
  get "/recently_fav_prod_deals", to: "favorite_product_deals#recently_fav_prod_deals"
  get "/user_details", to: "users#user_details"
  get "/prod_deal_comments/:product_deal_id", to: "user_comments#product_deal_comments"
  resources :favorite_product_deals, only: [:create, :destroy]
end
