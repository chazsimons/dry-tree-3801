Rails.application.routes.draw do

  get '/doctors/:id', to: 'doctors#show'
end
