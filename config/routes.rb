Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
     post :create_order, to: "customer_orders#create"
    end
  end
end
