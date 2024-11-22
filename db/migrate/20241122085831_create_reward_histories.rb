class CreateRewardHistories < ActiveRecord::Migration[7.1]
  def change
    create_table :reward_histories do |t|
      t.integer :points
      t.integer :given_by
      t.integer :given_to

      t.timestamps
    end
  end
end
