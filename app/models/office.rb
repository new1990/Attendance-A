class Office < ApplicationRecord
  validates :office_number, presence: true, length: { maximum: 10 }
  validates :office_name, presence: true, length: { maximum: 30 }
end
