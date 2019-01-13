class RemoveAttachmentFromTicketes < ActiveRecord::Migration[5.2]
  def change
    remove_column :ticketes, :attachment, :string
  end
end
