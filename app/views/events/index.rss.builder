xml.instruct! :xml, :version=>"1.0" 
xml.rss(:version=>"2.0"){
  xml.channel{
    xml.title("#{@cms_config['website']['name']} Events")
    xml.link(events_url(:format => :rss))
    # xml.description("")
    xml.language('en-us')

    for event in Event.future
      xml.item do
        xml.title(h(event.title))
        xml.category(h(event.event_categories.first.title)) unless event.event_categories.empty?
        xml.description(h(event.blurb))
        xml.pubDate(event.created_at.strftime("%a, %d %b %Y %H:%M:%S %z"))
        xml.link(article_url(event))
        xml.guid(article_url(event))
      end
    end
  }
}
