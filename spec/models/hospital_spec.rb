require 'rails_helper'

RSpec.describe Hospital do
  before :each do
    @gh = Hospital.create!({name: 'General Hospital'})
    @scrubs = Hospital.create({name: 'Scrubs Hospital'})
    @childrens = Hospital.create({name: 'Childrens Hospital'})

    @doc_1 = Doctor.create!({name: 'Donovan Doctor', specialty: 'General Practice', university: 'Stanford Law', hospital_id: @gh.id})
    @doc_2 = Doctor.create!({name: 'Greg House', specialty: 'Crabby Specialist', university: 'Oxford', hospital_id: @gh.id})
    @doc_3 = Doctor.create!({name: 'Sandra Who', specialty: 'Time Surgery', university: 'TARDIS University', hospital_id: @childrens.id})
    @doc_4 = Doctor.create!({name: 'Lola Spratt', specialty: 'Pediactric Surgery', university: 'Clown College School of Medicine', hospital_id: @childrens.id})
    @doc_5 = Doctor.create!({name: 'Owen Maestro', specialty: 'Rhinoplasty', university: 'Clown College School of Medicine', hospital_id: @childrens.id})
    @doc_6 = Doctor.create!({name: 'JD Braff', specialty: 'Comedy Medicine', university: 'Harvard Medicine', hospital_id: @scrubs.id})
  end

  describe 'relationships' do
    it { should have_many(:doctors) }
  end

  it 'can return a count of doctors at a give hospital' do
    expect(@gh.doc_count).to eq(2)
    expect(@scrubs.doc_count).to eq(1)
    expect(@childrens.doc_count).to eq(3)
  end

  it 'can return a distinct list of schools doctors attended' do
    results = @childrens.unique_schools.map do |school|
                  school.name
                end
    expect(results).to eq(['Clown College School of Medicine', 'TARDIS University'])
  end
end
