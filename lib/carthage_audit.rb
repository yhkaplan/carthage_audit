require 'net/http'
require 'oga'

def get_repo(lib)
  File.open("Cartfile", "r") do |f|
    f.each_line do |line|
      next unless matches = line.match(/^github "(.*#{Regexp.quote(lib)})"/)
      repo = matches[1]

      puts repo
      return repo
    end
  end

  repo = "#{lib}/#{lib}"
end

def make_request(url)
  uri = URI(url)

  resp = Net::HTTP.start(uri.host, uri.port, :use_ssl => uri.scheme == 'https') do |http|
	req = Net::HTTP::Get.new uri.request_uri
	http.request req
  end
end

# TODO: replace w/ actual call to carthage outdated
File.open("carthage_output.txt", "r") do |f|
  f.each_line do |line|
    next unless matches = line.match(/^(.*?) "(.*?)" -> "(.*?)"/) # TODO: match the part in Latest instead

    lib = matches[1]
    old_version = matches[2]
    new_version = matches[3]

    puts "lib: #{lib}, #{old_version}, #{new_version}"

    next if old_version == new_version

    repo = get_repo(lib)

    url = "https://github.com/#{repo}/releases/tag/#{new_version}"
    puts url

    resp = make_request(url)
    puts resp.code

    # next unless resp.code == 200 # not matching for some reason...
    # Parse HTML and search body for keywords
    body = resp.body
    # puts body

    d = Oga.parse_html(body)
    # md = d.xpath("div[contains(@class, 'markdown-body')]")
    md = d.css('.markdown-body').each do |n|
      puts n.text
      n.css('ul li').each do |l| # get only first ul
	puts l.text
      end
    end

    # puts md
    # For each li item in print
  end
end
