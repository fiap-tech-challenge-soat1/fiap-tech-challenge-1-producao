Rails.application.routes.draw do
  mount Rswag::Ui::Engine => "/api-docs"
  mount Rswag::Api::Engine => "/api-docs"

  get "up" => "rails/health#show", :as => :rails_health_check

  root "pedidos#index"

  get "pedidos", to: "pedidos#index"
  post "pedidos", to: "pedidos#create"
  put "pedidos/:num_pedido", to: "pedidos#update"
end
