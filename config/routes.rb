Aficionado::Application.routes.draw do

  resources :posts, only: [:create], constraint: { format: :json }
  resources :pieces, only: [:show], constraint: { format: :json }

end
