class Hospital < ApplicationRecord
  has_many :doctors

  def doc_count
    doctors.count
  end
end
