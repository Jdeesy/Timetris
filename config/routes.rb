Rails.application.routes.draw do
  get 'auth/:provider/callback', to: 'sessions#create'
  get 'auth/failure', to: redirect('/')
  get 'signout', to: 'sessions#destroy', as: 'signout'

  root 'home#index'
  get '/welcome' => 'home#welcome', as: 'welcome'
  get '/future' => 'home#future', as: 'future'
  get '/past' => 'home#past', as: 'past'

  get '/complete_calendar' => 'home#complete_calendar', as: 'complete_calendar'

  patch '/tasks/:id/start' => 'tasks#start', as: "start_task"
  patch '/tasks/:id/complete' => 'tasks#complete', as: "complete_task"
  patch '/tasks/:id/cancel' => 'tasks#cancel', as: "cancel"

  post '/tasks/:id/tb_sub' => 'tasks#time_box_subtract'
  post '/tasks/:id/tb_add' => 'tasks#time_box_add'
  post '/tasks/:id/pr_sub' => 'tasks#priority_subtract'
  post '/tasks/:id/pr_add' => 'tasks#priority_add'

  get '/tasks/:id/start' => 'tasks#start'

  get '/users/alert' => 'users#alert'
  patch '/users/snooze' => 'users#snooze'

  get '/settings' => 'users#edit', as: 'edit_user'
  patch '/settings' => 'users#update', as: 'user'

  resources :sessions, only: [:create, :destroy]
  resources :tasks

  get "*path", to: redirect('/')
end
