xml.instruct! :xml, :version => "1.0"
xml.rss :version => "2.0" do
  xml.channel do
    xml.title "Turs.Pro"
    xml.description "Последние туры"
    xml.link turs_url
    for tur in @turs
      xml.item do
        xml.title tur.title
        xml.description tur.description
        xml.pubDate tur.created_at.to_s(:rfc822)
        xml.link tur_url(tur)
        xml.guid tur_url(tur)
      end
    end
  end
end