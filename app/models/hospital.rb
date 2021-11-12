class Hospital < ApplicationRecord
  has_many :doctors

  def doc_count
    doctors.count
  end

  def unique_schools
    doctors.select('university AS name').distinct
  end
end
