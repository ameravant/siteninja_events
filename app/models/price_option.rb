class PriceOption < ActiveRecord::Base
  belongs_to :event
  named_scope :public, :conditions => ["public = ?", true]
end