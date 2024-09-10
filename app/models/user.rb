class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # we have use enum it will dicide role of user
  enum role: { contractor: 0, worker: 1 }


  # Associations
  has_many :jobs, foreign_key: :contractor_id, dependent: :destroy
  has_many :applications, foreign_key: :worker_id, dependent: :destroy

  # Validations
  # validates :name, presence: true
  # validates :email, presence: true, uniqueness: true
  # validates :role, presence: true

  # Validations
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :role, presence: true, inclusion: { in: %w[contractor worker admin], message: "must be contractor, worker, or admin" }
  validates :name, presence: true
  validates :phone, format: { with: /\A\d{10}\z/, message: "must be 10 digits" }, allow_blank: true
end
