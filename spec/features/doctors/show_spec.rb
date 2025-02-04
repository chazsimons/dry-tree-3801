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
    @dp_5 = DoctorPatient.create!({doctor_id: @doc_4.id, patient_id: @patient_1.id})
  end

  it 'displays a single doctor and their attributes' do
    visit "/doctors/#{@doc_1.id}"

    expect(page).to have_content(@gh.name)
    expect(page).to have_content(@doc_1.name)
    expect(page).to have_content(@doc_1.specialty)
    expect(page).to have_content(@doc_1.university)
    expect(page).to_not have_content(@doc_2.name)
    expect(page).to_not have_content(@childrens.name)
  end

  it 'displays a list of patients being treated by that doctor' do
    visit "/doctors/#{@doc_1.id}"

    expect(page).to have_content(@patient_1.name)
    expect(page).to have_content(@patient_2.name)
    expect(page).to_not have_content(@patient_3.name)
  end

  it 'has a button to remove a patient from a doctor' do
    visit "/doctors/#{@doc_1.id}"

    expect(page).to have_content(@patient_1.name)
    expect(page).to have_button("Remove Patient")

    within("#patient-#{@patient_1.id}") do
      click_button "Remove Patient"
    end
    expect(current_path).to eq("/doctors/#{@doc_1.id}")
    expect(page).to_not have_content(@patient_1.name)
  end
end
