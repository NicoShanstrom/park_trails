Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
  get "/asheville_parks", to: "asheville_parks#index"
  patch "/asheville_parks/:id", to: "asheville_parks#update", :as => :asheville_park 
  get "/asheville_parks/new", to: "asheville_parks#new"
  get "/asheville_parks/:id", to: "asheville_parks#show"
  post "/asheville_parks", to: "asheville_parks#create"
  get "/asheville_parks/:id/edit", to: "asheville_parks#edit"
  delete "/asheville_parks/:id", to: "asheville_parks#destroy"

  get "/trails/:id/edit", to: "trails#edit"
  patch "/trails/:id", to: "trails#update"
  get "/trails/:id", to: "trails#show"
  get "/trails", to: "trails#index"
  delete "/trails/:id", to: "trails#destroy"


  get "/asheville_parks/:id/trails/new", to: "asheville_parks_trails#new"
  post "/asheville_parks/:id/trails", to: "asheville_parks_trails#create"
  get "/asheville_parks/:id/trails", to: "asheville_parks_trails#index"
end
