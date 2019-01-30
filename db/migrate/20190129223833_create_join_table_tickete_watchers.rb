class CreateJoinTableTicketeWatchers < ActiveRecord::Migration[5.2]
  def change
    create_join_table :ticketes, :users, table_name: :tickete_watchers do |t|
      # t.index [:tickete_id, :user_id]
      # t.index [:user_id, :tickete_id]
    end
  end
end
