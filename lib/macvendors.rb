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
      MacVendors.setup
      puts MacVendors.find2(value)
    end

    desc :update, "update/replace the mac address csv from ieee"
    def update
      MacVendors.setup
      MacVendors.update()
    end

    desc :install, "install your first vendors"
    def install
      MacVendors.download()
    end

  end

  private

  def self.update
    path_to_file = "#{Dir.home}/.macvendors/oui.csv"
    File.delete(path_to_file) if File.exist?(path_to_file)
    puts "vendors removed."
    MacVendors.download()
  end


  def self.download
    Dir.mkdir "#{Dir.home}/.macvendors" if File.directory?("#{Dir.home}/.macvendors") == nil
    open("#{Dir.home}/.macvendors/oui.csv", 'wb') do |file|
      file << open('http://standards-oui.ieee.org/oui/oui.csv').read
    end
    puts "downloaded vendors"
  end

  def self.search value
    column = @answer["Assignment"]
    name = @answer["Organization Name"]
    hash = Hash[column.map.with_index.to_a]
    final_answer = ""
    if hash[value] != nil
      final_answer =  name[hash[value]]
    else
      final_answer = nil # "something went wrong."
    end
    return final_answer
  end

  def self.setup
    path = "#{Dir.home}/.macvendors/oui.csv"
    @answer = CSV.read(path,:headers=> true, :encoding => "ISO8859-1:utf-8") #TODO: is this a data
  end

  def self.find2 string
    MacVendors.setup
    string = string.gsub(":", "")
    string = string.gsub("-", "")
    return search(string[0..5].upcase)
  end

  def self.find string
    string = string.gsub(":", "")
    string = string.gsub("-", "")
    return search(string[0..5].upcase)
  end

end
