class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :recoverable, :rememberable, :trackable, :validatable, :omniauthable, omniauth_providers: %i[google_oauth2]

  validates :first_name, presence: true
  validates :last_name, presence: true

  validates :email, presence: true

  belongs_to :dealership, optional: true

  scope :admin, ->{ where(dealership_id: nil) }
  scope :customer, ->{ where.not(dealership_id: nil) }

  def self.from_omniauth(env)
    find_by email: env.info.email
  end

  def name
    [first_name, last_name].join(' ')
  end
end