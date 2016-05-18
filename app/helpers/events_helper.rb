module EventsHelper
  
def get_timezone(time)
  
end

  def soon_indicator(event_datetime, prefix="&mdash; ", capitalize_text=false)
    # Only outputs something if the event is less than a week away
    return if event_datetime > 1.week.from_now

    if event_datetime.today?
      span_text = "today!"
      span_class = "event-today"
    elsif event_datetime.to_date == Date.tomorrow
      span_text = "tomorrow!"
      span_class = "event_today"
    elsif event_datetime < 2.weeks.from_now
      span_text = "in #{time_ago_in_words event_datetime}!"
      span_class = "event_soon"
    elsif event_datetime <= 1.month.from_now
      span_text = "in #{time_ago_in_words event_datetime}"
      span_class = "event_soon"
    end
    span_text.capitalize! if capitalize_text
    content_tag :span, "#{prefix}#{span_text}", :class => span_class
  end
  
  def payments_allowed(e, s)
    o = []
    o << "Credit Card" if e.allow_card
    o << "Cash" if e.allow_cash
    o << "Check" if (e.allow_check and e.check_instructions)
    o.join(", ")
  end

  def display_event_price(p)
    [0,nil].include?(p) ? "Free" : number_to_currency(p)
  end



end
