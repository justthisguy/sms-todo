# == Schema Information
#
# Table name: tasks
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  done       :boolean
#  created_at :datetime
#  updated_at :datetime
#  list_id    :integer
#  phone      :string(255)
#


class Task < ActiveRecord::Base
    
    belongs_to :list, :class_name => "List", :foreign_key => "list_id"
    
    validates :name, :presence => true


end



