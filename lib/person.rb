class Person < ActiveRecord::Base
  require "#{RAILS_ROOT}/vendor/plugins/siteninja/siteninja_core/app/models/person.rb"
  has_many :event_registrations
  has_many :event_registration_groups, :through => :event_registrations
end