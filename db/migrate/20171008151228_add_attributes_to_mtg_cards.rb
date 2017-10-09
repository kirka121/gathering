class AddAttributesToMtgCards < ActiveRecord::Migration[5.1]
  def change
    add_column :mtg_cards, :card_number, :string, default: nil
  end
end
