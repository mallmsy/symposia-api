class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.string :title
      t.string :description
      t.date :publish_date
      t.string :author
      t.string :content
      t.string :source
      t.string :img_url
      t.string :link
      t.string :slant

      t.timestamps
    end
  end
end
