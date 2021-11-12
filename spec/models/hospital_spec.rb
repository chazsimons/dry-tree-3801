require 'rails_helper'

RSpec.describe Hospital do
  before :each do
    @gh = Hospital.create!({name: 'General Hospital'})
    @scrubs = Hospital.create({name: 'Scrubs Hospital'})
    @childrens = Hospital.create({name: 'Childrens Hospital'})

    @doc_1 = Doctor.create!({name: 'Donovan Doctor', specialty: 'General Practice', university: 'Stanford Law', hospital_id: @gh.id})
    @doc_2 = Doctor.create!({name: 'Greg House', specialty: 'Crabby Specialist', university: 'Oxford', hospital_id: @gh.id})
    @doc_3 = Doctor.create!({name: 'Sandra Who', specialty: 'Time Surgery', university: 'TARDIS University', hospital_id: @scrubs.id})
    @doc_4 = Doctor.create!({name: 'Lola Spratt', specialty: 'Pediactric Surgery', university: 'Clown College School of Medicine', hospital_id: @childrens.id})
  end

  describe 'relationships' do
    it { should have_many(:doctors) }
  end

  it 'can return a count of doctors at a give hospital' do
    expect(@gh.doc_count).to eq(2)
    expect(@scrubs.doc_count).to eq(1)
    expect(@childrens.doc_count).to eq(1)
  end
end
