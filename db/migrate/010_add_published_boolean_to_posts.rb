class AddPublishedBooleanToPosts < ActiveRecord::Migration
  def self.up
    change_table :posts do |t|
      t.boolean :published, :default => false
    end
  end

  def self.down
    change_table :posts do |t|
      t.remove :published
    end
  end
end
