class DoctorPatientsController < ApplicationController

  def destroy
    DoctorPatient.where({doctor_id: params[:doc_id], patient_id: params[:patient_id]}).destroy_all
    redirect_to "/doctors/#{params[:doc_id]}"
  end
end
