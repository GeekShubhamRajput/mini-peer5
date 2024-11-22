Rails.application.routes.draw do
  resources :users do
    member do
      resources :reward_histories, only: [:index, :new, :create]
      delete 'reward_histories/:id', to: 'reward_histories#destroy', as: :delete_reward
    end
  end

  root 'users#index'
end
