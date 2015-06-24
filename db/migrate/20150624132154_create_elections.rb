class CreateElections < ActiveRecord::Migration
  def change
    create_table :elections do |t|
      t.belongs_to :campaign, index: true
      t.belongs_to :candidate, index: true
    end
    add_index :elections, [:campaign_id, :candidate_id], unique: true
  end
end
