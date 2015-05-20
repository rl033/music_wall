class AddColumnToTracks < ActiveRecord::Migration

  def change
    add_column :tracks, :user_id, :integer, references: :users
  end
end