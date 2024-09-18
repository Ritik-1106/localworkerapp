class JobApplication  < ApplicationRecord
  # Associations
  belongs_to :job
  belongs_to :worker, class_name: "User"

  # Enums
  enum status: { Pending: "Pending", Accepted: "Accepted", Rejected: "Rejected" }

  # Validations
  validates :status, presence: true
  validates :job_id, presence: true
  validates :worker_id, presence: true
  validates :description, presence: true
  validates :softskills, presence: true
end
