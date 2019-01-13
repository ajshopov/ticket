class AddAttachmentToTicketes < ActiveRecord::Migration[5.2]
  def change
    add_column :ticketes, :attachment, :string
  end
end
