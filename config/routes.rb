Rails.application.routes.draw do
  scope :api do
    resource :trips, only: :create
    get '/stats/weekly', to: 'stats#weekly'
    get '/stats/monthly', to: 'stats#monthly'
  end
end
