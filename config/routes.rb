Rails.application.routes.draw do
  # scope constraints: { subdomain: 'portal' } do
    devise_for :users, path: '', controllers: { omniauth_callbacks: 'omniauth_callbacks' }

    namespace :api, defaults: { format: :json } do
      namespace :v1 do
        resources :dealerships do
          resources :templates do
            post :preview, action: :preview, on: :collection
            get :preview, action: :preview, on: :member
          end
          resources :contracts
        end
        resource :vin, controller: :vin

        resources :service_providers, path: 'service-providers'
        resources :users

        resources :contracts, only: [:index]
      end
    end

    # we could accomplish the following with a single glob, but this gives
    # us some flexibility in the future and keeps things a bit more 'tight'
    scope controller: 'portal', action: 'boot' do
      get 'contracts/:id'
      get 'contracts'

      get 'dealerships/:id/contracts/new'
      get 'dealerships/:id/contracts/:id/edit'
      get 'dealerships/:id/contracts/:id'
      get 'dealerships/:id/templates/new'
      get 'dealerships/:id/templates/:id/edit'
      get 'dealerships/:id/users/new'
      get 'dealerships/:id/users/:id/edit'
      get 'dealerships/new'
      get 'dealerships/:id/edit'
      get 'dealerships/:id'
      get 'dealerships'

      get 'users/new'
      get 'users/:id/edit'
      get 'users'
    end

    root to: 'portal#boot'
  # end


  # root to: 'site#home'
end
