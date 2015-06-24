class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.integer :vote_time
      t.string :validity
      t.references :election
    end
  end
end
