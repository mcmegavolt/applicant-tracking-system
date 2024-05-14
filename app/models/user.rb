class User < ApplicationRecord
  include Devise::JWT::RevocationStrategies::JTIMatcher

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable, :registerable
  # :omniauthable, :recoverable, :rememberable, :validatable
  devise :database_authenticatable, :jwt_authenticatable, jwt_revocation_strategy: self
end
