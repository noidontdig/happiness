class CreateTweets < ActiveRecord::Migration
  def change
    create_table :tweets do |t|
      t.integer :t_id
      t.string :text
      t.integer :user_id
      t.datetime :time

      t.timestamps
    end
  end
end
