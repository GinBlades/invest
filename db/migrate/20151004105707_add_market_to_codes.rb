class AddMarketToCodes < ActiveRecord::Migration
  def change
    add_column :codes, :market, :string
  end
end
