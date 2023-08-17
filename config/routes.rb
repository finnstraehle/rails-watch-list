Rails.application.routes.draw do
  resources :movies, only: %i[index show]
  resources :lists, only: %i[index show new create] do
    resources :bookmarks, only: %i[create new]
  end
  resources :bookmarks, only: %i[destroy]
end
