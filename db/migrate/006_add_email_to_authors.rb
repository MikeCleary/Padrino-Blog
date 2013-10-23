class AddEmailToAuthors < ActiveRecord::Migration

  #Add a column
  def self.up            # Vcolumn name and type
    add_column :authors, :email, :string
  end          # ^table to be changed

  #Down method reverses migration
  def self.down
    remove_column :authors, :email
  end
end