require 'rails_helper'

RSpec.describe Patient do
  before :each do
    @patient_1 = Patient.create!({name: 'Joe Somebody', age: 55})
    @patient_2 = Patient.create!({name: 'Doug Ross', age: 35})
    @patient_3 = Patient.create!({name: 'Kerry Weaver', age: 40})
    @patient_4 = Patient.create!({name: 'John Carter', age:41})
  end

  describe 'relationships' do
    it { should have_many(:doctor_patients) }
    it { should have_many(:doctors).through(:doctor_patients) }
  end

  describe '#by_age' do
    it 'orders patients by age' do
      results = Patient.by_age.map do |person|
                  person.name
                end

      expect(results).to eq([@patient_1.name, @patient_4.name, @patient_3.name, @patient_2.name])
    end
  end
end
