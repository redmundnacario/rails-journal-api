class CreateTasks < ActiveRecord::Migration[6.1]
  def change
    create_table :tasks do |t|
      t.string :title
      t.text :description
      t.date :deadline
      t.boolean :done

      t.timestamps

      t.references :journal
      t.references :user
    end
  end
end
