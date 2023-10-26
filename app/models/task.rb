class Task < ApplicationRecord
  belongs_to :user

  validates :name, presence: true
  validates :label, presence: true
  validates :priority, presence: true
  validates :state, presence: true
  validates :date, presence: true
  validates :description, presence: true

end
