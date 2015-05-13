Rails.application.routes.draw do
  get 'auth/:provider/callback', to: 'sessions#create'
  get 'auth/failure', to: redirect('/')
  get 'signout', to: 'sessions#destroy', as: 'signout'

  root 'home#index'
  get '/pending' => 'home#pending', as: 'pending'
  get '/completed' => 'home#completed', as: 'completed'
  get '/reports' => 'home#reports', as: 'reports'
  get '/welcome' => 'home#welcome', as: 'welcome'
  get '/autocal' => 'home#autocal', as: 'autocal'
  get '/complete_calendar' => 'home#complete_calendar', as: 'complete_calendar'

  patch '/tasks/:id/start' => 'tasks#start', as: "start_task"
  patch '/tasks/:id/complete' => 'tasks#complete', as: "complete_task"

  post '/tasks/:id/tb_sub' => 'tasks#time_box_subtract'
  post '/tasks/:id/tb_add' => 'tasks#time_box_add'
  post '/tasks/:id/pr_sub' => 'tasks#priority_subtract'
  post '/tasks/:id/pr_add' => 'tasks#priority_add'

  get '/tasks/:id/start' => 'tasks#start'
  get '/users/alerts' => 'users#alerts'
  patch '/users/snooze' => 'users#snooze'

  get '/settings' => 'users#edit', as: 'edit_user'
  patch '/settings' => 'users#update', as: 'user'

  resources :sessions, only: [:create, :destroy]
  resources :tasks, only: [:create, :show, :edit, :update, :destroy]

  get "*path", to: redirect('/')
end
