class CreateComments < ActiveRecord::Migration
  def self.up
    create_table :comments do |t|
      t.text :content
      t.integer :post_id
      t.date :comment_date
      t.integer :parent_id
      t.timestamps
    end
  end

  def self.down
    drop_table :comments
  end
end
