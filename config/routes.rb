Aficionado::Application.routes.draw do

  resources :posts, only: [:create], constraint: { format: :json }

  resources :pieces, only: [:index], constraint: { format: :json }




end
