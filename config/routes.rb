Rails.application.routes.draw do
  scope :v1 do
    get 'confirmations/:token', to: "confirmations#confirm", as: :user_confirm

    resources :teams, only: [ :create, :destroy ]
  end
end
