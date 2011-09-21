class CreateBookmarks < ActiveRecord::Migration
  def change
    create_table :bookmarks do |t|
      t.string :url
      t.string :name
      t.date :date

      t.timestamps
    end
  end
end
