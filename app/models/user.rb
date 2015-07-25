class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable

  reverse_geocoded_by :latitude, :longitude# do |obj, results| end
  #after_validation :reverse_geocode  # auto-fetch address

  has_many :maps
  has_many :map_users, dependent: :destroy
  has_many :map_memberships, through: :map_users, source: :map
end
