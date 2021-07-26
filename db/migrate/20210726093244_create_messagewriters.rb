class CreateMessagewriters < ActiveRecord::Migration[6.1]
  def change
    create_table :messagewriters do |t|
      t.string :username

      t.timestamps
    end
  end
end
