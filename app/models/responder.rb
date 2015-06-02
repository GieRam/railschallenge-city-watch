class Responder < ActiveRecord::Base
  self.primary_key = 'name'

  self.inheritance_column = :_type_disabled
  validates :name, presence: true, uniqueness: true
  validates :capacity, presence: true, inclusion: 1..5
  validates :type, presence: true
end
