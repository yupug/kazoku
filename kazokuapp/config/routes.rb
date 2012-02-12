#coding: utf-8

Kazokuapp::Application.routes.draw do
  resources :kazokus
  resources :users
  resources :photos
  resources :comments
  
  match "logout" => "login#logout"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  match ':controller(/:action(/:id))(.:format)'
end
