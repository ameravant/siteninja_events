xml.instruct! :xml, :version=>"1.0" 
xml.rss(:version=>"2.0"){
  xml.channel{
    xml.title(@cms_config['website']['name'])
    xml.link(event_category_url(@event_category, :format => :rss))
    # xml.description("")
    xml.language('en-us')

    for event in @events
      xml.item do
        xml.title(h(event.title))
        xml.category(h(@event_category.title))
        xml.description(h(event.blurb))
        xml.pubDate(event.created_at.strftime("%a, %d %b %Y %H:%M:%S %z"))
        xml.link(event_url(event))
        xml.guid(event_url(event))
      end
    end
  }
}
