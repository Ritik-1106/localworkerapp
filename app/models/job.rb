class Job < ApplicationRecord
  # associations among with models
  belongs_to :contractor, class_name: "User"
  belongs_to :category
  has_many :applications

  # model level validations
  validates :name, presence: true, length: { maximum: 100 }
  validates :description, presence: true, length: { minimum: 10 }
  validates :salary, presence: true
  validates :location, presence: true
  validates :contractor_id, presence: true
  validates :category_id, presence: true
end
