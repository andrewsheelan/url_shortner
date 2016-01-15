class CreateUrls < ActiveRecord::Migration
  def change
    create_table :urls do |t|
      t.string :slug, null: false
      t.string :long_url
      t.boolean :slugged, default: false
      t.timestamps
    end
    add_index :urls, :slug, unique: true
  end
end
