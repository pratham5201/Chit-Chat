class User < ApplicationRecord
  has_many :userchats
  has_many :chats
  has_and_belongs_to_many :groups
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
