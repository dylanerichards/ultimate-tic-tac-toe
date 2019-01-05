class CreateGames < ActiveRecord::Migration[5.2]
  def change
    create_table :games do |t|
      t.text :board, array: true, default: []
      t.text :valid_subgames, array: true, default: [0, 1, 2, 3, 4, 5, 6, 7, 8]
      t.string :winner, default: ""
      t.string :turn, default: "X"

      t.timestamps
    end
  end
end
