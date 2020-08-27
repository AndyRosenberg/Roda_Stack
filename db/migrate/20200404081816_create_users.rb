class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :email
      t.string :name
      t.string :password
      t.string :time_zone, default: "UTC"
      t.string :reset_token
      t.datetime :sent_time
      t.timestamps
    end
  end
end
