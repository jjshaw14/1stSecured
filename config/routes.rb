Rails.application.routes.draw do
  devise_for :users, path: '', controllers: { omniauth_callbacks: 'omniauth_callbacks' }

  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :dealerships

      resources :templates do
        post :preview, action: :preview, on: :collection
        get :preview, action: :preview, on: :member
        get :terms, action: :terms, on: :collection
      end

      resources :contracts do
        resource :attachment, only: :show
      end

      resources :claims do
        member do
          get :attachment, to: 'attachments#claim'
        end
      end

      resource :vin, controller: :vin

      resources :service_providers, path: 'service-providers'
      resources :users

      resources :contracts, only: [:index]

      resources :fees

      resource :me, controller: :me, only: %i[show update]
    end
  end

  # we could accomplish the following with a single glob, but this gives
  # us some flexibility in the future and keeps things a bit more 'tight'
  scope controller: 'portal', action: 'boot' do
    get '/profile/edit'
    get 'contracts/:id'
    get 'contracts'

    get 'contracts/new'
    get 'contracts/:id/edit'
    get 'contracts/:id'
    get 'contracts/:contract_id/claims/new'
    get '/claims/:id/edit'
    get 'templates/new'
    get 'templates/:id/edit'
    get 'dealerships/:id/users/new'
    get 'dealerships/:id/users/:id/edit'
    get 'dealerships/new'
    get 'dealerships/:id/edit'
    get 'dealerships/:id'
    get 'dealerships'
    get 'dealerships/:dealership_id/templates/new'
    get 'service-providers/new'
    get 'service-providers/:id/edit'
    get 'service-providers'

    get 'users/new'
    get 'users/:id/edit'
    get 'users'

    get 'claims'
    get 'claims/:id'
  end

  root to: 'portal#boot'
end
