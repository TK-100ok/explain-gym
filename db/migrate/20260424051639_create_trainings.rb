class CreateTrainings < ActiveRecord::Migration[7.2]
  def change
    create_table :trainings do |t|
      t.string :theme
      t.text :explanation
      t.references :user, null: false, foreign_key: true
      t.references :target, null: false, foreign_key: true
      t.string :custom_target

      t.timestamps
    end
  end
end
