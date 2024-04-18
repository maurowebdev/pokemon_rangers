class CreateRangers < ActiveRecord::Migration[7.1]
  def change
    create_table :rangers do |t|
      t.string :first_name, null: false
      t.string :last_name
      t.string :email, null: false
      t.string :password_digest, null: false
      t.string :identification_number, null: false

      t.timestamps
    end
  end
end
