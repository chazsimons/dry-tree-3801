# User Story 2, Hospital Show Page
# ​
# As a visitor
# When I visit a hospital's show page
# I see the hospital's name
# And I see the number of doctors that work at this hospital -count of .doctors
# And I see a unique list of universities that this hospital's doctors attended -ar distinct
require 'rails_helper'

RSpec.describe 'Hospital Show Page' do
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
    @patient_4 = Patient.create!({name: 'John Carter', age:40})

    @dp_1 = DoctorPatient.create!({doctor_id: @doc_1.id, patient_id: @patient_1.id})
    @dp_2 = DoctorPatient.create!({doctor_id: @doc_1.id, patient_id: @patient_2.id})
    @dp_3 = DoctorPatient.create!({doctor_id: @doc_1.id, patient_id: @patient_4.id})
    @dp_4 = DoctorPatient.create!({doctor_id: @doc_2.id, patient_id: @patient_3.id})
  end

  it 'displays a hospitals name' do
    visit "/hospitals/#{@childrens.id}"

    expect(page).to have_content(@childrens.name)
    expect(page).to_not have_content(@gh.name)
  end

  it 'has a count of its doctors' do
    visit "/hospitals/#{@childrens.id}"

    expect(page).to have_content("Number of Doctors in Residence: #{@childrens.doc_count}")
  end

  it 'displays a list of unique schools its doctors attended' do
    doc_5 = Doctor.create!({name: 'Owen Maestro', specialty: 'Rhinoplasty', university: 'Clown College School of Medicine', hospital_id: @childrens.id})

    visit "/hospitals/#{@childrens.id}"

    expect(page).to have_content(@doc_3.university)
    expect(page).to have_content(@doc_4.university, count: 1)
    expect(page).to have_content(@doc_2.university)
  end
end
