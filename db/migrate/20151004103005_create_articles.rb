class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.string :name, null: false
      t.string :summary
      t.string :link

      t.timestamps null: false
    end
  end
end
