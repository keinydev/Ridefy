class CreateTrips < ActiveRecord::Migration[6.1]
  def change
  	enable_extension 'hstore' unless extension_enabled?('hstore')
    create_table :trips do |t|
      t.hstore     :start_location,  null: false
      t.hstore     :end_location,    null: false
      t.datetime   :start_time,      null: false
      t.datetime   :end_time,        null: false
      t.belongs_to :driver,          null: false, index: true, foreign_key: true
      t.belongs_to :rider,           null: false, index: true, foreign_key: true
      t.belongs_to :car,             null: false, index: true, foreign_key: true
      t.timestamps
    end
  end
end
