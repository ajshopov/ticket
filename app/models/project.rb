class Project < ApplicationRecord
  has_many :ticketes
  validates :name, presence: true
end
