# frozen_string_literal: true

Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  namespace :api do
    namespace :v1 do
      resources :users, only: [] do
        member do
          post :follow
          delete :unfollow
        end
      end

      resources :tweets, only: %i[index create]
    end
  end
end
