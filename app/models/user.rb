class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable, :registerable
  # :omniauthable, :recoverable, :rememberable, :validatable
  devise :database_authenticatable
end
