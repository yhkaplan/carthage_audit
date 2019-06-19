require "net/http"
require "oga"

class Audit
  # :name string, :current_version string, :new_version string, :update_info_list string
  Dependency = Struct.new(
    :name,
    :current_version,
    :new_version,
    :update_info_list
  )

  def get_repo(name)
    File.open("Cartfile", "r") do |f|
      f.each_line do |line|
        next unless matches = line.match(/^github "(.*#{Regexp.quote(name)})"/)

        repo = matches[1]
        return repo
      end
    end

    "#{name}/#{name}" # repo
  end

  def make_request(url)
    uri = URI(url)

    _ = Net::HTTP.start(uri.host, uri.port, use_ssl: uri.scheme == "https") do |http|
      req = Net::HTTP::Get.new(uri.request_uri)
      http.request(req)
    end
  end

  def get_list_items_from_html(html)
    a = []

    d = Oga.parse_html(html)
    _ = d.css(".markdown-body").each do |n|
      n.css("ul li").each do |l| # TODO: get only first ul
        a << l.text
      end
    end

    a
  end

  def has_vulnerability(info_list)
    # word_pattern = /(vulnerability|vulnerabilities|security|attack|advisory|unsecure|critical|alert)/
    word_pattern = /(fix|bug)/ # TODO: for testing purposes
    info_list.detect { |i| i.downcase =~ word_pattern }
  end

  def run
    # TODO: replace w/ actual call to carthage outdated
    File.open("carthage_output.txt", "r") do |f|
      f.each_line do |line|
        next unless matches = line.match(/^(.*?) "(.*?)" -> "(.*?)"/) # TODO: match the part in Latest instead

        name = matches[1]
        current_version = matches[2]
        new_version = matches[3]

        dep = Dependency.new(name, current_version, new_version, nil)

        next if current_version == new_version

        repo = get_repo(name)
        url = "https://github.com/#{repo}/releases/tag/#{new_version}"
        resp = make_request(url)

        # next unless resp.code == 200 # not matching for some reason...
        update_info_list = get_list_items_from_html(resp.body)
        dep.update_info_list = update_info_list

        # TODO: check list for keywords like vulnerability, security, emergency, etc,
        if vulnerability_fix = has_vulnerability(dep.update_info_list)
          # then send slack notification if applicable or fail the build
          puts "Security Alert: #{dep.name}"
          puts vulnerability_fix
        end
      end
    end
  end

end
