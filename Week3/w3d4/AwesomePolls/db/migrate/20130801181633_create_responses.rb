class CreateResponses < ActiveRecord::Migration
  def change
    create_table :user_responses do |t|
      t.integer :user_id
      t.integer :response_id
      t.timestamps
    end
  end
end
