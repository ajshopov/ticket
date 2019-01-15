class Comment < ApplicationRecord
  belongs_to :tickete
  belongs_to :author, class_name: "User"

  scope :persisted, lambda { where.not(id: nil) }
  
  validates :text, presence: true
  delegate :project, to: :tickete
end
