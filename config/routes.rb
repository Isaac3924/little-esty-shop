Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :merchants, only: :show do 
    resources :dashboard, only: :index, controller: "merchants/dashboard"
    resources :items, except: :destroy, controller: "merchants/items"
    resources :invoices, only: [:index, :show, :update], controller: "merchants/invoices"
    resources :bulk_discounts, only: [:index, :show, :new, :create] , controller: "merchants/bulk_discounts"
  end
  
  namespace :admin do
    get '/', to: 'dashboard#index'
    resources :merchants, except: :destroy
    resources :invoices, only: [:index, :show, :update]
  end
end