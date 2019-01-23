class Comment < ApplicationRecord
  belongs_to :previous_state, class_name: "State", optional: true
  belongs_to :state, optional: true
  belongs_to :tickete
  belongs_to :author, class_name: "User"

  scope :persisted, lambda { where.not(id: nil) }
  
  validates :text, presence: true
  delegate :project, to: :tickete

  before_create :set_previous_state
  after_create :set_tickete_state

  private

  def set_previous_state
    self.previous_state = tickete.state
  end

  def set_tickete_state
    tickete.state = state
    tickete.save!
  end
end
