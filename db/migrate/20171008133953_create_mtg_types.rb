class CreateMtgTypes < ActiveRecord::Migration[4.2]
  def self.up
    create_table :mtg_types do |t|
      t.string     :name
      t.timestamps
    end
  end

  def self.down
    drop_table :mtg_types
  end
end
