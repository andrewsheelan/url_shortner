class CreateUrls < ActiveRecord::Migration
  def change
    create_table :urls do |t|
      t.string :uid, null: false
      t.string :long_url
      t.boolean :slugged, default: false
      t.timestamps
    end
    add_index :urls, :uid, unique: true
  end
end
