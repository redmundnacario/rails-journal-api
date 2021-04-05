# Rails.application.routes.draw do
  # resources :tasks
  # resources :journals
#   # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
# end


Rails.application.routes.draw do
  resources :tasks

  match '/tasks/journal/:id' => "tasks#get_tasks_by_journal_id", via: [:get], as: :get_tasks_by_journal_id
  match '/today/tasks' => "tasks#get_tasks_today", via: [:get], as: :get_tasks_today

  resources :journals

  resource :users, only: [:create]
  resource :user, only: [:update, :destroy] , as: :user
  
  # patch "/user/:id", to: "users#update", as: :user
  # put "/user/:id", to: "users#update"
  # delete "/user/:id", to: "users#destroy"

  # match "/user/:id" => "user#update", via: [:put], as: :user
  # # match "/user/:id" => "user#update", via: [:patch], as: :update
  # match "/user/:id" => "user#destroy", via: [:delete], as: :user


  post "/login", to: "users#login"
  get "/auto_login", to: "users#auto_login"

end