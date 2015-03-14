class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.datetime :time
      t.text :description
      t.string :status

      t.timestamps null: false
    end
  end
end
