# User Story 1, Doctors Show Page
# ​
# As a visitor
# When I visit a doctor's show page
# I see all of that doctor's information including:
#  - name
#  - specialty
#  - university where they got their doctorate
# And I see the name of the hospital where this doctor works
# And I see the names of all of the patients this doctor has
require 'rails_helper'

RSpec.describe 'Doctor Show Page' do
  before :each do
    @gh = Hospital.create!({name: 'General Hospital'})
    @scrubs = Hospital.create({name: 'Scrubs Hospital'})
    @childrens = Hospital.create({name: 'Childrens Hospital'})

    @doc_1 = Doctor.create!({name: 'Donovan Doctor', specialty: 'General Practice', university: 'Stanford Law', hospital_id: @gh.id})
    @doc_2 = Doctor.create!({name: 'Greg House', specialty: 'Crabby Specialist', university: 'Oxford', hospital_id: @gh.id})
    @doc_3 = Doctor.create!({name: 'Sandra Who', specialty: 'Time Surgery', university: 'TARDIS University', hospital_id: @scrubs.id})
    @doc_4 = Doctor.create!({name: 'Lola Spratt', specialty: 'Pediactric Surgery', university: 'Clown College School of Medicine', hospital_id: @childrens.id})

    @patient_1 = Patient.create!({name: 'Joe Somebody', age: 55})
    @patient_2 = Patient.create!({name: 'Doug Ross', age: 35})
    @patient_3 = Patient.create!({name: 'Kerry Weaver', age: 40})
    @patient_4 = Patient.create!({name: 'John Carter', age:40})

    @dp_1 = DoctorPatient.create!({doctor_id: @doc_1.id, patient_id: @patient_1.id})
    @dp_2 = DoctorPatient.create!({doctor_id: @doc_1.id, patient_id: @patient_2.id})
    @dp_3 = DoctorPatient.create!({doctor_id: @doc_1.id, patient_id: @patient_4.id})
    @dp_4 = DoctorPatient.create!({doctor_id: @doc_2.id, patient_id: @patient_3.id})
  end

  it 'displays a single doctor and their attributes' do
    visit "/doctors/#{@doc_1.id}"

    expect(page).to have_content(@doc_1.name)
    expect(page).to have_content(@doc_1.specialty)
    expect(page).to have_content(@doc_1.university)
  end
end
