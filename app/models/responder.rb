class Responder < ActiveRecord::Base
  self.primary_key = 'name'

  self.inheritance_column = :_type_disabled
  validates :name, presence: true, uniqueness: true
  validates :capacity, presence: true, inclusion: 1..5
  validates :type, presence: true

  scope :capacity_all_by_type, -> { group(:type).sum(:capacity) }
  scope :capacity_all_by_type_available, -> { group(:type).where(emergency_code: nil).sum(:capacity) }
  scope :capacity_all_by_type_on_duty, -> { group(:type).where(on_duty: true).sum(:capacity) }
  scope :capacity_all_by_type_on_duty_available, -> { group(:type).where(on_duty: true).where(emergency_code: nil).sum(:capacity) }

end
