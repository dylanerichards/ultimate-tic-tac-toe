Rails.application.routes.draw do
  get "/game", to: "games#show"

  post "/game", to: "games#new"

  post "/move", to: "games#move"
end
