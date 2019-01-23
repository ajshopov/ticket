class AddPreviousStateToComments < ActiveRecord::Migration[5.2]
  def change
    add_reference :comments, :previous_state
    add_foreign_key :comments, :states, column: :previous_state_id
  end
end
