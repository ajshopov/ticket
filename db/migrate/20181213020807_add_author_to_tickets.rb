class AddAuthorToTickets < ActiveRecord::Migration[5.2]
  def change
    add_reference :ticketes, :author, index: true
    add_foreign_key :ticketes, :users, column: :author_id
  end
end
