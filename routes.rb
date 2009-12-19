resources :events, :as => events_path, :has_many => :images, :collection => { :past => :get } do |event|
  event.resources :event_registrations,
    :belongs_to => :people,
    :has_many => :event_registration_people,
    :member => { :pay => :get, :complete => :get }
end

namespace :admin do |admin|
  admin.resources :events, :has_many => [ :event_prices, :features, :assets ] do |event|
    event.resources :images, :member => { :reorder => :put }, :collection => { :reorder => :put }
    event.resources :event_registrations,
      :has_many => :contacts,
      :member => { :csv => :get, :paid => :get, :unpaid => :get }
  end
end

addpeople '/addpeople', :controller => "registration_people", :action => "index"

