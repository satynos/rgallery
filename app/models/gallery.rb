class Gallery < ActiveRecord::Base
  has_many :photos
  belongs_to :user
  
  validates_presence_of :name 
  
  def belongs_to?(other_user)
    user == other_user
  end
  
  def to_param
    "#{id}-#{name.parameterize}"
  end
end
