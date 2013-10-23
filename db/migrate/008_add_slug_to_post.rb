class AddSlugToPost < ActiveRecord::Migration
  
  def self.up
    add_column :posts, :slug, :string
  end

  def self.end
    remove_column :posts, :slug    
  end
end