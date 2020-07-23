Rails.application.routes.draw do
  get('/', to: "welcome#root", as: :root)
  resources :tasks
  get('/complete_task/:id/', to: "tasks#complete_task", as: :complete_task)
  resources :users ,only: [:new, :create]
  resource :session, only: [:new,:create, :destroy]
end
