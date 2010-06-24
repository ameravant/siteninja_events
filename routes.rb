resources :events, :as => events_path, :has_many => :images, :collection => { :past => :get} do |event|
  event.resources :event_registrations,
    :belongs_to => :people,
    :has_many => :event_registration_people,
    :member => { :pay => :get, :complete => :get }
end

namespace :admin do |admin|
  admin.resources :event_categories, :has_many => { :features, :menus } do |event_category|
    event_category.resources :menus
    event_category.resources :images, :member => { :reorder => :put }, :collection => { :reorder => :put }
  end
  admin.resources :events, :has_many => [ :event_prices, :features, :assets ] do |event|
    event.resources :images, :member => { :reorder => :put }, :collection => { :reorder => :put }
    event.resources :event_registrations,
      :has_many => :contacts,
      :member => { :csv => :get, :paid => :get, :unpaid => :get }
  end
end
resources :event_categories

addpeople '/addpeople', :controller => "registration_people", :action => "index"


