class UpdatePossibleResponses < ActiveRecord::Migration
  def change
      drop_table :possible_responses

      create_table :responses do |t|
        t.integer :question_id
        t.string :response
        t.timestamps
      end

      add_index :responses, :question_id
  end
end
