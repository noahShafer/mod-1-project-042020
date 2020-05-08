class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :username
      t.string :display_name
      t.string :email
      t.string :password
      t.string :profile_pic
    end
  end
end
