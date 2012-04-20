# == Schema Information
#
# Table name: lists
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#
class List < ActiveRecord::Base
  
  validates :name, :presence => true
  validates_uniqueness_of :name, :on => :create, :message => "must be unique"
  
  has_many :tasks , :dependent => :destroy

  def done_tasks
     tasks.where(:done => true).order("updated_at DESC")
  end
  
end

# == Schema Information
#
# Table name: lists
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

