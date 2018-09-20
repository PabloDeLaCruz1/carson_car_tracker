require "CSV"
CSV.foreach("./CAR_DATA.csv") do |row, i|
  p row
end
