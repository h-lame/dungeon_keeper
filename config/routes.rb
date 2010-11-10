DungeonKeeper::Application.routes.draw do
  resources :trap_installations

  resources :traps

  resources :evil_wizards

  resources :dungeons

  root :to => 'dungeons#index'
end
