class EventCategory < ActiveRecord::Base
  has_permalink :title
  belongs_to :column
  has_many :events
  has_and_belongs_to_many :events
  has_many :features, :as => :featurable, :dependent => :destroy
  has_many :images, :as => :viewable, :dependent => :destroy
  has_many :menus, :as => :navigatable, :dependent => :destroy
  has_many :column_section_event_categories
  has_many :column_sections, :through => :column_section_event_categories
  validates_presence_of :title
  named_scope :active, :conditions => { :active => true }
  default_scope :order => "title", :conditions => { :active => true }
  
  def to_param
    "#{self.id}-#{self.permalink}"
  end  
  
  def name
    self.title
  end
end
