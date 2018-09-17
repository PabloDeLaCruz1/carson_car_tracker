require "CSV"
CSV.foreach("./CAR_DATA.csv") do |row|
  p row
end
