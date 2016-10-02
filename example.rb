require 'macvendors'

input = ""
output = ""

#take in the csv
data = CSV.read(input)
mac_addresses = data["mac"]
puts "This csv contains no mac address column named 'mac'" if mac_addresses.count == 0
MacVendors.setup

#output
mac_addresses.times.each_with_index do |index, row|
MacVendors.find(row)
end
