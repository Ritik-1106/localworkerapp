class Category < ApplicationRecord
  has_many :jobs
  # validations
  validates :name, presence: true, uniqueness: true, length: { maximum: 50 }
end
