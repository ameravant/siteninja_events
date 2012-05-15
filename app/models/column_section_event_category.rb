class ColumnSectionEventCategory < ActiveRecord::Base
  belongs_to :column_section
  belongs_to :event_category
  default_scope :order => :sort_order
end
