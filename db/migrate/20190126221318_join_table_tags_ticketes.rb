class JoinTableTagsTicketes < ActiveRecord::Migration[5.2]
  def change
    create_join_table :tags, :ticketes do |t|
      t.index [:tag_id, :tickete_id]
      t.index [:tickete_id, :tag_id]
    end
  end
end
