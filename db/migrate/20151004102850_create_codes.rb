class CreateCodes < ActiveRecord::Migration
  def change
    create_table :codes do |t|
      t.belongs_to :company, index: true, foreign_key: true
      t.string :symbol, null: false
      t.string :description

      t.timestamps null: false
    end
  end
end
