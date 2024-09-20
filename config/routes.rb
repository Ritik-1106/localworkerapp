Rails.application.routes.draw do
  # Root route
  root "homes#index"

  # Devise routes for authentication with custom sessions controller
  devise_for :users

  # Custom routes
  get "contractor", to: "homes#contractor" # Route for contractor action
  get "worker", to: "homes#worker"

  resource :profile, only: [ :new, :create, :edit, :update, :show ]

  # Routes for UsersController (for user profiles)
  resources :users, only: [ :show, :edit, :update ]

  # Routes for JobsController and nested ApplicationsController
  resources :jobs do
    resources :job_applications, only: [ :new, :create, :show ] do
      collection do
        get :total_applicants  # Route to view all applicants
      end
    end

    collection do
      get :my_jobs # Route for contractors to view their own jobs
      get :worker_all_jobs
    end
  end

  resources :job_applications, only: [] do
    collection do
      get :my_applications  # Route for workers to view their job applications
      # Route for all jobs (for workers)
    end
  end


  # get "jobs/index", to: "jobs#index", as: "filtered_jobs"

  # Route for total applicants
  get "total_applicants", to: "jobs#total_applicants"
end
