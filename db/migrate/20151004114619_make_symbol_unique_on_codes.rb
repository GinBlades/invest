class MakeSymbolUniqueOnCodes < ActiveRecord::Migration
  def change
    add_index :codes, :symbol, unique: true
  end
end
