Rails.application.routes.draw do
  get 'confirmations/:token', to: "confirmations#confirm", as: :user_confirm
  scope :api do
    scope :v1 do
      resources :teams, only: [ :create, :destroy ]
    end
  end
end
