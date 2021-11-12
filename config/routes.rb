Rails.application.routes.draw do

  get '/doctors/:id', to: 'doctors#show'

  get '/hospitals/:hospital_id', to: 'hospitals#show'
end
