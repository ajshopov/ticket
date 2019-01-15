class Comment < ApplicationRecord
  belongs_to :state, optional: true
  belongs_to :tickete
  belongs_to :author, class_name: "User"

  scope :persisted, lambda { where.not(id: nil) }
  
  validates :text, presence: true
  delegate :project, to: :tickete

  after_create :set_tickete_state

  private

  def set_tickete_state
    tickete.state = state
    tickete.save!
  end
end
