class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # we have use enum it will dicide role of user
  enum role: { contractor: 0, worker: 1 }


  # Associations
  has_many :jobs, foreign_key: :contractor_id, dependent: :destroy
  has_many :job_applications, foreign_key: :worker_id, dependent: :destroy
  has_one :profile, dependent: :destroy


  # Validations
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :role, presence: true, inclusion: { in: %w[contractor worker], message: "must be contractor, worker" }
  validates :name, presence: true
  validates :contact_no, format: { with: /\A\d{10}\z/, message: "must be 10 digits" }, allow_blank: true
end
