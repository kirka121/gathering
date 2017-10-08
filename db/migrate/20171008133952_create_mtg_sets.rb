class CreateMtgSets < ActiveRecord::Migration[4.2]
  def self.up
    create_table :mtg_sets do |t|
      t.string     :name
      t.timestamps
    end
  end

  def self.down
    drop_table :mtg_sets
  end
end
