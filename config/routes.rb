DungeonKeeper::Application.routes.draw do
  resources :traps do
    resources :trap_installations
  end

  resources :evil_wizards

  resources :dungeons do
    resources :trap_installations
  end

  root :to => 'dungeons#index'
end
