class CreateStickies < ActiveRecord::Migration[5.2]
  def change
    create_table :stickies do |t|
      t.string :text
      t.string :color

      t.timestamps
    end
  end
end
