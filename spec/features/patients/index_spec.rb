require 'rails_helper'

RSpec.describe 'Patient Index Page' do
  before :each do
    @gh = Hospital.create!({name: 'General Hospital'})
    @scrubs = Hospital.create({name: 'Scrubs Hospital'})
    @childrens = Hospital.create({name: 'Childrens Hospital'})

    @doc_1 = Doctor.create!({name: 'Donovan Doctor', specialty: 'General Practice', university: 'Stanford Law', hospital_id: @gh.id})
    @doc_2 = Doctor.create!({name: 'Greg House', specialty: 'Crabby Specialist', university: 'Oxford', hospital_id: @childrens.id})
    @doc_3 = Doctor.create!({name: 'Sandra Who', specialty: 'Time Surgery', university: 'TARDIS University', hospital_id: @childrens.id})
    @doc_4 = Doctor.create!({name: 'Lola Spratt', specialty: 'Pediactric Surgery', university: 'Clown College School of Medicine', hospital_id: @childrens.id})

    @patient_1 = Patient.create!({name: 'Joe Somebody', age: 55})
    @patient_2 = Patient.create!({name: 'Doug Ross', age: 35})
    @patient_3 = Patient.create!({name: 'Kerry Weaver', age: 40})
    @patient_4 = Patient.create!({name: 'John Carter', age:41})

    @dp_1 = DoctorPatient.create!({doctor_id: @doc_1.id, patient_id: @patient_1.id})
    @dp_2 = DoctorPatient.create!({doctor_id: @doc_1.id, patient_id: @patient_2.id})
    @dp_3 = DoctorPatient.create!({doctor_id: @doc_1.id, patient_id: @patient_4.id})
    @dp_4 = DoctorPatient.create!({doctor_id: @doc_2.id, patient_id: @patient_3.id})
  end

  it 'lists the patients from oldest to youngest' do
    visit "/patients"

    expect(@patient_1.name).to appear_before(@patient_2.name)
    expect(@patient_4.name).to appear_before(@patient_3.name)
    expect(@patient_2.name).to_not appear_before(@patient_1.name)
  end
end
