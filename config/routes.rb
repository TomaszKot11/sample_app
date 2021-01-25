Rails.application.routes.draw do
  scope :api do
    resource :trip, only: :create
  end
end
