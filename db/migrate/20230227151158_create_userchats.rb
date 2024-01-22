class CreateUserchats < ActiveRecord::Migration[7.0]
  def change
    create_table :userchats do |t|
      t.text :message
      t.integer :sender
      t.integer :receiver
      t.integer :user_id
      t.string :username

      t.timestamps
    end
  end
end
