class Event < ActiveRecord::Base
  has_permalink :name
  belongs_to :person
  belongs_to :master_group, :class_name => "PersonGroup", :foreign_key => "master_group_id"
  #has_many :event_prices, :dependent => :destroy
  has_many :event_registration_groups
  has_many :event_price_options
  has_many :images, :as => :viewable, :dependent => :destroy
  has_many :features, :as => :featurable, :dependent => :destroy
  has_many :assets, :as => :attachable, :dependent => :destroy
  has_and_belongs_to_many :event_categories
  #validates_datetime :registration_deadline, :allow_blank => true
  #validates_datetime :date_and_time, :end_date_and_time
  before_validation :validates_end_is_after_start
  validates_presence_of :name, :date_and_time, :end_date_and_time
  validates_numericality_of :registration_limit, :allow_blank => true
  validates_presence_of :registration, :if => :allow_check_or_cash?, :message => "must be required if you accept cash or check payment"
  named_scope :future, :conditions => ["date_and_time >= ?", Time.now]
  named_scope :this_week, :conditions => { :date_and_time => (Time.now..(Time.now + 7.days)) }
  named_scope :this_month, :conditions => { :date_and_time => (Time.now..(Time.now + 29.days))  }
  named_scope :three_months,:conditions => { :date_and_time => (Time.now..(Time.now + 3.months))  }
  named_scope :this_year, :conditions => { :date_and_time => (Time.now..Time.now.next_year)  }
  named_scope :past, :order => "date_and_time desc", :conditions => ["end_date_and_time < ?", Time.now]
  named_scope :not_yet_complete, :order => "date_and_time desc", 
    :conditions => ["end_date_and_time > ? OR end_date_and_time = ?", Time.now, '']
  named_scope :in_progress, :order => "date_and_time desc", 
    :conditions => ["date_and_time < ? AND end_date_and_time > ?", Time.now, Time.now]
  named_scope :soonest, :limit => 6
  default_scope :order => "date_and_time"
  # accepts_nested_attributes_for :event_price_options
  def to_param
    "#{self.id}-#{self.permalink}"
  end
  
  def self.not_yet_complete
    Event.in_progress.concat(Event.future)
  end
  
  # def end_date_and_time
  #   self.read_attribute(:date_and_time)
  # end
  
  def title
    self.name
  end
  
  def is_closed?
    self.is_full? || self.is_past_deadline?
  end
  
  def is_full?
    if self.registration_count.blank? || self.registration_limit.blank?
      false
    else
     self.registration_count >= self.registration_limit 
   end
  end
  
  def is_past_deadline?
    deadline = self.registration_deadline ? self.registration_deadline : self.date_and_time
    if !deadline.blank?
      Time.now > deadline
    else
      false
    end
  end

  def registration_count
    self.event_registration_groups.collect(&:event_registrations).flatten.size
  end

  def spots_available
    self.registration_limit - self.registration_count
  end

  def registration_spots?
    self.registration_limit ? (self.registration_count < self.registration_limit) : true
  end

  def registration_limit?
    self.registration_limit
  end

  def allow_check_or_cash?
    self.allow_check? or self.allow_cash?
  end

  def future_date?
    self.date_and_time >= Time.now
  end

  def today?
    self.date_and_time.strftime('%Y-%m-%d') == Time.now.strftime('%Y-%m-%d') 
  end

  def tomorrow?
    self.date_and_time < (Time.now + 1.day) and !self.today?
  end

  def this_week?
    self.date_and_time <= Time.now + 7.days
  end

  def validates_end_is_after_start
    errors.add(:end_date_and_time, 'must be after the start time.') and return false if end_date_and_time < date_and_time
  end
  
  def allowed_payment_methods
    payment_methods = []
    payment_methods << "Cart" if self.allow_card
    payment_methods << "Cash" if self.allow_cash
    payment_methods << "Check" if self.allow_check
    payment_methods << "Other" if self.allow_other
    payment_methods.join(', ')
  end
end

