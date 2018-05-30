class User < ApplicationRecord
  include Canable::Cans

  has_paper_trail meta: { user_id: :id, dealership_id: :dealership_id }

  devise :database_authenticatable, :recoverable, :rememberable, :trackable, :validatable, :omniauthable, omniauth_providers: %i[google_oauth2]
  enum user_type: {
    owner: 0,
    employee: 1
  }
  validates :first_name, presence: true
  validates :last_name, presence: true

  validates :email, presence: true

  belongs_to :dealership, optional: true

  scope :admin, -> { where(dealership_id: nil) }
  scope :customer, -> { where.not(dealership_id: nil) }
  scope :available_to, ->(user) {
    if user.dealership.nil?
      all
    elsif user.dealership && user.owner?
      where(dealership: user.dealership)
    else
      none
    end
  }
  def self.from_omniauth(env)
    find_by email: env.info.email
  end

  def name
    [first_name, last_name].join(' ')
  end
  def admin?
    dealership_id.nil?
  end
end
