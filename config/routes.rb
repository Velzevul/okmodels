Okmodelagency::Application.routes.draw do
  devise_for :users

  root :to => "main#home"

  get "contact" => "main#contact", :as => "contact"
  get "latest" => "main#latest", :as => "latest"
  get "new-applications" => "main#new_applications", :as => "new_applications"

  resources :children, :controller => "models", :type => "Child" do
    get "approve" => "main#approve", :on => :member
    resources :photos, :only => [:create, :new, :destroy]
  end

  resources :men, :controller => "models", :type => "Man" do
    get "approve" => "main#approve", :on => :member
    resources :photos, :only => [:create, :new, :destroy]
  end

  resources :women, :controller => "models", :type => "Woman" do
    get "approve" => "main#approve", :on => :member
    resources :photos, :only => [:create, :new, :destroy]
  end
end
