class MapUser < ActiveRecord::Base
  belongs_to :map
  belongs_to :user

  validates_uniqueness_of :user_id, :scope => :map_id
end
