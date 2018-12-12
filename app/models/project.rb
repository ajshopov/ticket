class Project < ApplicationRecord
  has_many :ticketes, dependent: :delete_all
  validates :name, presence: true
end
