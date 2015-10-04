class CreateQuotes < ActiveRecord::Migration
  def change
    create_table :quotes do |t|
      t.belongs_to :code, index: true, foreign_key: true
      t.jsonb :json

      t.timestamps null: false
    end
  end
end
