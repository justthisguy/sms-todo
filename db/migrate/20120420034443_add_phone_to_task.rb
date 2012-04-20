class AddPhoneToTask < ActiveRecord::Migration
  def self.up
    add_column :tasks, :phone, :string
  end

  def self.down
    remove_column :tasks, :phone
  end
end
