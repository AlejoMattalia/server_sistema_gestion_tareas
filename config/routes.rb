Rails.application.routes.draw do
  namespace 'authentication' do
    resources :users, only: [:index, :create]
    resources :sessions, only: [:create]
    get 'user_data', to: "sessions#user_data"
  end
  
  get 'tasks/user/:user_id', to: 'tasks#tasks_for_user', as: 'user_tasks'
  resources :tasks
end
