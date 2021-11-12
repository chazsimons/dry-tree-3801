Rails.application.routes.draw do

  get '/doctors/:id', to: 'doctors#show'

  get '/hospitals/:hospital_id', to: 'hospitals#show'

  delete '/doctors/:doc_id/patients/:patient_id', to: 'doctor_patients#destroy'
  
end
