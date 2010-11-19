DungeonKeeper::Application.routes.draw do
  resources :traps do
    resources :trap_installations
  end

  resources :evil_wizards

  resources :dungeons do
    resources :trap_installations
  end

  resources :monsters, :only => [:new, :create]

  root :to => 'dungeons#index'
end
