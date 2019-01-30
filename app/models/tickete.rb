class Tickete < ApplicationRecord
  belongs_to :project
  belongs_to :author, class_name: "User" # assign author to the user model
  belongs_to :state, optional: true
  has_many :attachments, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_and_belongs_to_many :tags, distinct: true
  has_and_belongs_to_many :watchers, join_table: "tickete_watchers",
    class_name: "User", distinct: true
  
  attr_accessor :tag_names

  validates :name, presence: true
  validates :description, presence: true, length: { minimum: 10 }

  accepts_nested_attributes_for :attachments, reject_if: :all_blank

  before_create :assign_default_state
  after_create :author_watches_me

  # searcher do
  #   label :tag, from: :tags, field: "name"
  # end

  def tag_names=(names)
    @tag_names = names
    names.split.each do |name|
      self.tags << Tag.find_or_initialize_by(name: name)
    end
  end

  private

  def author_watches_me
    if author.email.present? && !self.watchers.include?(author)
      self.watchers << author
    end
  end

  def assign_default_state
    self.state ||= State.default
  end
end
