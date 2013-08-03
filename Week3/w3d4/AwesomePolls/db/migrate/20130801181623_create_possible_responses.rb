class CreatePossibleResponses < ActiveRecord::Migration
  def change
    create_table :responses do |t|
      t.integer :question_id
      t.string :response
      t.timestamps
    end

    add_index :possible_responses, :question_id
  end
end
