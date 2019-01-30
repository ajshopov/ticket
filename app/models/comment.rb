class Comment < ApplicationRecord
  belongs_to :previous_state, class_name: "State", optional: true
  belongs_to :state, optional: true
  belongs_to :tickete
  belongs_to :author, class_name: "User"
  attr_accessor :tag_names

  scope :persisted, lambda { where.not(id: nil) }
  
  validates :text, presence: true
  delegate :project, to: :tickete

  before_create :set_previous_state
  after_create :set_tickete_state
  after_create :associate_tags_with_tickete
  after_create :author_watches_tickete

  private

  def set_previous_state
    self.previous_state = tickete.state
  end

  def set_tickete_state
    tickete.state = state
    tickete.save!
  end

  def associate_tags_with_tickete
    if tag_names
      tag_names.split.each do |name|
        tickete.tags << Tag.find_or_create_by(name: name)
      end
    end
  end

  def author_watches_tickete
    if author.email.present? && !tickete.watchers.include?(author)
      tickete.watchers << author
    end
  end
end
