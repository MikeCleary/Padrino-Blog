class AddPopularityToTag < ActiveRecord::Migration

  def self.up
    add_column :tags, :popularity, :integer
  end

  def self.down 
    remove_column :tags, :popularity
  end
end