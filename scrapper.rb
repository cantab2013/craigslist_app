# scrapper.rb
require 'nokogiri'
require 'open-uri'

def filter_links(rows, regex)
  # takes in rows and returns uses
  # regex to only return links 
  # that have "pup", "puppy", or "dog"
  # keywords

  i = 0
  result = []

  while i < rows.length do
    # puts rows[i][:title]
    if rows[i][:title].downcase.match(regex) != nil
      result.push({url: rows[i][:url], title: rows[i][:title]})
    end
    i+=1
  end

  puts result

end

def get_todays_rows(doc, date_str)
  #  1.) open chrome console to look in inside p.row to see
  #  if there is some internal date related content

  #  2.) figure out the class that you'll need to select the
  #   date from a row

  arr = []

  doc.each do |e|
    if e.css(".date").text.strip == date_str
      # puts e.css("a")
      arr.push({url: e.at_css("a")["href"], title: e.css(".hdrlnk").text.strip})
    end
    # {row: e, date: e.css(".date").text.strip}
  end   

  regex = /pup*|dog*/
  filter_links(arr, regex)

end

def get_page_results
  url = "http://sfbay.craigslist.org/sfc/pet/"
  Nokogiri::HTML(open(url))
end

def search(date_str)
  get_todays_rows(get_page_results.css(".content p.row span.pl"), date_str)
  
end

# today.html http://sfbay.craigslist.org/sfc/pet/
# want to learn more about 
# Time in ruby??
#   http://www.ruby-doc.org/stdlib-1.9.3/libdoc/date/rdoc/Date.html#strftime-method
today = Time.now.strftime("%b %d")
# puts today
search(today)