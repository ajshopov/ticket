class Project < ApplicationRecord
  has_many :ticketes, dependent: :delete_all
  validates :name, presence: true
  has_many :roles, dependent: :delete_all
end
