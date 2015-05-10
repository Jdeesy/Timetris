Rails.application.routes.draw do
  get 'auth/:provider/callback', to: 'sessions#create'
  get 'auth/failure', to: redirect('/')
  get 'signout', to: 'sessions#destroy', as: 'signout'

  root 'home#index'
  get '/pending' => 'home#pending', as: 'pending'
  get '/completed' => 'home#completed', as: 'completed'
  get '/reports' => 'home#reports', as: 'reports'
  get '/welcome' => 'home#welcome', as: 'welcome'

  patch '/tasks/:id/start' => 'tasks#start', as: "start_task"
  patch '/tasks/:id/complete' => 'tasks#complete', as: "complete_task"

  patch '/tasks/:id/tb_sub' => 'tasks#timebox_subtract'
  patch '/tasks/:id/tb_add' => 'tasks#timebox_add'
  patch '/tasks/:id/pr_sub' => 'tasks#priority_subtract'
  patch '/tasks/:id/pr_add' => 'tasks#priority_add'

  resources :sessions, only: [:create, :destroy]
  resources :tasks #, only: [:index, :create, :update, :destroy]
end
