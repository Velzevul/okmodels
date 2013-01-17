Okmodelagency::Application.routes.draw do
  devise_for :users

  root :to => "main#home"

  get "contact" => "main#contact", :as => "contact"
  get "latest" => "main#latest", :as => "latest"

  resources :children, :women, :men do
    resources :photos, :only => [:create, :new, :destroy]
  end
end
