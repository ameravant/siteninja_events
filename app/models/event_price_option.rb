class EventPriceOption < ActiveRecord::Base
  belongs_to :event
  named_scope :public, :conditions => ["public = ?", true]
  
  def title_and_price
    "#{self.title}-$#{self.price}"
  end
end