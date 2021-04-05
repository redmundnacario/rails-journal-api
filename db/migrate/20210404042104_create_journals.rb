class CreateJournals < ActiveRecord::Migration[6.1]
  def change
    create_table :journals do |t|
      t.string :title
      t.text :description

      t.timestamps

      t.references :user
    end
  end
end
