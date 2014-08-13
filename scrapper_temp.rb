# scrapper.rb
require 'nokogiri'
require 'open-uri'



def filter_links(rows, regex)
  # takes in rows and returns uses
  # regex to only return links 
  # that have "pup", "puppy", or "dog"
  # keywords
end

def get_todays_rows(doc, date_str)
  #  1.) open chrome console to look in inside p.row to see
  #  if there is some internal date related content

  #  2.) figure out the class that you'll need to select the
  #   date from a row

end

def get_page_results
  url = "http://sfbay.craigslist.org/sfc/pet/"
  Nokogiri::HTML(open(url))
end

def search(date_str)
  arr = []
  result = []

  get_page_results.css(".content p.row span.pl").each do |e|
    if e.css(".date").text.strip == date_str
      # puts e.css("a")
      arr.push({url: e.at_css("a")["href"], title: e.css(".hdrlnk").text.strip})
    end
    # {row: e, date: e.css(".date").text.strip}
  end    
  
  # puts arr
  i = 0
  regex = /pup*|dog*/
  while i < arr.length do
    # puts arr[i][:title]
    if arr[i][:title].downcase.match(regex) != nil
      result.push({url: arr[i][:url], title: arr[i][:title]})
    end
    i+=1
  end

  puts result
    # {title: link.text, url: link["href"]}    

  # puts get_page_results.css(".content p.row span.date")
end

# today.html http://sfbay.craigslist.org/sfc/pet/
# want to learn more about 
# Time in ruby??
#   http://www.ruby-doc.org/stdlib-1.9.3/libdoc/date/rdoc/Date.html#strftime-method
today = Time.now.strftime("%b %d")
# puts today
search(today)