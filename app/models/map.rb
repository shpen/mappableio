class Map < ActiveRecord::Base
  belongs_to :user
  has_many :map_users, dependent: :destroy
  has_many :members, through: :map_users, source: :user

  validates :title, uniqueness: true
end
