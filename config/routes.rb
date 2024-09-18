Rails.application.routes.draw do
  # Root route


  # Devise routes for authentication with custom sessions controller
  devise_for :users
  root "homes#index"


  # this is custom route
  get "contractor", to: "homes#contractor" # Route for contractor action
  get "worker", to: "homes#worker"

  resource :profile, only: [ :new, :create, :edit, :update, :show ]

  # Routes for UsersController (for user profiles)
  resources :users, only: [ :show, :edit, :update ]

  # Routes for JobsController and nested ApplicationsController
  resources :jobs do
    resources :job_applications, only: [ :new, :create ] do
      collection do
        get :total_applicants  # Route to view all applicants
      end
      member do
        patch :update_status   # Route to update application status
      end
    end
  end
end
