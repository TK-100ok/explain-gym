class CreateAiFeedbacks < ActiveRecord::Migration[7.2]
  def change
    create_table :ai_feedbacks do |t|
      t.references :training, null: false, foreign_key: true
      t.text :good_points
      t.text :improvement_points
      t.text :overall_comment
      t.integer :score

      t.timestamps
    end
  end
end
