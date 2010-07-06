class EventCategory < ActiveRecord::Base
  has_permalink :title
  has_and_belongs_to_many :events
  has_many :features, :as => :featurable, :dependent => :destroy
  has_many :images, :as => :viewable, :dependent => :destroy
  has_many :menus, :as => :navigatable, :dependent => :destroy
  validates_presence_of :title
  named_scope :active, :conditions => { :active => true }
  default_scope :order => "title"
  
  def to_param
    "#{self.permalink}"
  end  
end
