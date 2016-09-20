require "macvendors/version"
require 'digest/md5'
require 'open-uri'
require 'thor'
require 'csv'

module MacVendors
  class Base < Thor
    check_unknown_options!
    package_name 'macvendors'
    default_task :help

    desc :find, "find the vendor for this mac address"
    def find value
      MacVendors.find(value)
    end

    desc :update, "update/replace the mac address csv from ieee"
    def update
      MacVendors.update()
    end

    desc :install, "install your first oui.csv"
    def install
      MacVendors.download()
    end

  end

  private

  def self.update
    path_to_file = "/Users/ytbryan/.macvendors/oui.csv"
    File.delete(path_to_file) if File.exist?(path_to_file)
    puts "oui.csv removed."
    MacVendors.download()
  end


  def self.download
    Dir.mkdir ".macvendors" if Dir[".macvendors"] == nil
    open("/Users/ytbryan/.macvendors/oui.csv", 'wb') do |file|
      file << open('http://standards-oui.ieee.org/oui/oui.csv').read
    end
    puts "downloaded oui.csv"
  end

  def self.search value
    path = "/Users/ytbryan/.macvendors/oui.csv"
    answer = CSV.read(path,:headers=> true, :encoding => "ISO8859-1:utf-8") #TODO: is this a data
    column = answer["Assignment"]
    name = answer["Organization Name"]
    hash = Hash[column.map.with_index.to_a]
    if hash[value] != nil
      puts name[hash[value]]
    else
      puts "something went wrong."
    end
    return name[hash[value]]
  end

  def self.find string
    string = string.gsub(":", "")
    string = string.gsub("-", "")
    return search(string[0..5].upcase)
  end

end
