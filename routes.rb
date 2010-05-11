resources :events, :as => events_path, :has_many => :images, :collection => { :past => :get } do |event|
  event.resources :event_registration_groups,
    :belongs_to => :people,
    :has_many => :event_registrations,
    :member => { :pay => :get, :complete => :get }
end

namespace :admin do |admin|
  admin.resources :events, :has_many => [ :event_price_options, :features, :assets ] do |event|
    event.resources :images, :member => { :reorder => :put }, :collection => { :reorder => :put }
    event.resources :event_registration_groups,
      :has_many => :contacts,
      :member => {:paid => :get, :unpaid => :get }, 
      :collection => {:csv => :get}
  end
end

addpeople '/addpeople', :controller => "registration_people", :action => "index"


