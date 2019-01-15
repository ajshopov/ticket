class Tickete < ApplicationRecord
  belongs_to :project
  belongs_to :author, class_name: "User" # assign author to the user model
  has_many :attachments, dependent: :destroy
  has_many :comments, dependent: :destroy

  validates :name, presence: true
  validates :description, presence: true, length: { minimum: 10 }

  accepts_nested_attributes_for :attachments, reject_if: :all_blank
end
