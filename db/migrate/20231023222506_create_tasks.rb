class CreateTasks < ActiveRecord::Migration[7.0]
  def change
    create_table :tasks do |t|
      t.string :name
      t.string :label
      t.string :priority
      t.string :state
      t.string :date
      t.string :description

      t.timestamps
    end
  end
end
