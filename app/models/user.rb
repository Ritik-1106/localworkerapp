class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # we have use enum it will dicide role of user
  enum role: { contractor: 0, worker: 1 }


    # Associations
    has_many :jobs, dependent: :destroy

    # Validations
    validates :name, presence: true
    validates :email, presence: true, uniqueness: true
    validates :role, presence: true
end
