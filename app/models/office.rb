class Office < ApplicationRecord
  validates :office_number, presence: true, length: { maximum: 10 }, uniqueness: true
  validates :office_name, presence: true, length: { maximum: 30 }
end
