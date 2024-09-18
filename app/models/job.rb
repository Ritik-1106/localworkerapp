class Job < ApplicationRecord
  # associations among with models
  belongs_to :contractor, class_name: "User"
  belongs_to :category

  has_many :job_applications, dependent: :destroy

  validates :salary, presence: true
  validates :location, presence: true
  validates :contractor_id, presence: true
  validates :category_id, presence: true
  validates :vacancies, presence: true, numericality: { greater_than: 0 }
end
