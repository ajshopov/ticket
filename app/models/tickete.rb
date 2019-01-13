class Tickete < ApplicationRecord
  belongs_to :project
  belongs_to :author, class_name: "User" # assign author to the user model

  validates :name, presence: true
  validates :description, presence: true, length: { minimum: 10 }

  mount_uploader :attachment, AttachmentUploader
end
