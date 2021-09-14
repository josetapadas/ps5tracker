require "httparty"

SOURCES = {
  micropost: {
    url: "https://www.microspot.ch/de/computer-gaming/gaming/spielkonsolen--c211000/sony-playstation-5-825-gb--p0002509350",
    match: "Dieser Artikel ist zur Zeit nicht lieferbar."
  },
  fust: {
    url: "https://www.fust.ch/de/sony-playstation-5-_content---1--1266--8055329.html",
    match: "Leider können wir aufgrund der sehr hohen Nachfrage nicht alle Bestellungen berücksichtigen."
  },
  gamestop: {
    url: "https://www.gamestop.ch/PS5/Games/73794/playstation-5",
    match: "Derzeit nicht verfügbar."
  },
  galaxus: {
    url: ["https://www.galaxus.ch/de/s1/product/sony-playstation-5-de-fr-it-en-spielkonsole-12664145", "https://www.galaxus.ch/de/s1/product/sony-playstation-5-digital-edition-de-fr-it-en-spielkonsole-13329224?tagIds=1&supplier=406802"],
    match: "Aktuell nicht lieferbar und kein Liefertermin vorhanden."
  },
  melectronics: {
    url: ["https://www.melectronics.ch/de/p/785445700000/sony-playstation-5", "https://www.melectronics.ch/de/p/785445800000/sony-playstation-5-digital-edition"],
    match: "derzeit nicht verfügbar"
  },
  interdiscount: {
    url: "https://www.interdiscount.ch/de/computer-gaming/gaming/spielkonsolen--c211000/sony-playstation-5-825-gb--p0002509350",
    match: "Zur Zeit nicht lieferbar"
  },
  mediamarkt: {
    url: "https://www.mediamarkt.ch/de/product/_sony-ps-playstation-5-2018096.html",
    match: "Produkt momentan nicht verfügbar"
  },
}
 
def parse_single_url(url, match)
  page = HTTParty.get(url)
  !page.to_str.include? match
end

def parse_multiple_urls(urls, match)
  urls.inject(false) { |total, current| total or parse_single_url(current, match) }
end

result = SOURCES.map do |key, value|
  has_multiple = value[:url].kind_of? Array
  available = has_multiple ? parse_multiple_urls(value[:url], value[:match]) : parse_single_url(value[:url], value[:match])
  
  {key: key, stock: available}
end 

puts result
