require 'csv'
require 'macvendors'

output = "./output.csv"
mac_path = "./input.csv" #this is the file with mac address

##################################

mac_file = CSV.read(mac_path,:headers=> true, :encoding => "ISO8859-1:utf-8")

MacVendors.setup

CSV.open(output, "a+") do |csv|
  mac_file.each_with_index do |row, index|
    a_mac_address = row[4] #4 refers to the fifth column of the csv where mac address is
    answer = MacVendors.find(a_mac_address)
    array = []
    row.each_with_index do |_each_value,index|
      array.push(row[index])
    end
  	csv << array.push(answer)
  end
end
