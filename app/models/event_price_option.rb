class EventPriceOption < ActiveRecord::Base
  belongs_to :event
  named_scope :public, :conditions => ["public = ?", true]
  
  def title_and_price
    if self.price.blank?
      self.title
    else
      "#{self.title}-$#{self.price}"
    end
  end
end