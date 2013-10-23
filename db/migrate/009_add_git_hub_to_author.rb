class AddGitHubToAuthor < ActiveRecord::Migration
  def self.up
    change_table :authors do |t|
      t.string :github
    end
  end

  def self.down
    change_table :authors do |t|
      t.remove :github
    end
  end
end
