class Attachment < ApplicationRecord
  belongs_to :tickete

  mount_uploader :file, AttachmentUploader
end
