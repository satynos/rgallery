class Photo < ActiveRecord::Base
  belongs_to :gallery
  belongs_to :person
  
  validates_presence_of :title
  
  has_attached_file :file, 
                    :styles => { 
                                 :large => "1024x768>",
                                 :medium => "500x500>",
                                 :thumb => "100x100>" }
  def to_param
    "#{id}-#{title.parameterize}"
  end
  
end
