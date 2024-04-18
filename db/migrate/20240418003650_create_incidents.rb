class CreateIncidents < ActiveRecord::Migration[7.1]
  def change
    create_table :incidents do |t|
      t.string :location, null: false
      t.date :occurrence_date, null: false
      t.text :description, null: false
      t.references :ranger, null: false, foreign_key: true
      t.boolean :public_incident, null: false, default: false

      t.timestamps
    end
  end
end
