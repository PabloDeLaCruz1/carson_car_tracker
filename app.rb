# Based on http://www.jonathanleighton.com/articles/2011/awesome-active-record-bug-reports/

# Run this script with `$ pry app.rb`
require "active_record"
require "pg"
require "CSV"
require "sinatra"
# require_relative "./models"

# Use `binding.pry` anywhere in this script for easy debugging
require "pry"

# Connect to a postgresql database
# If you feel like you need to reset it, simply delete the file sqlite makes

ActiveRecord::Base.establish_connection(
  adapter: "postgresql",
  database: "carson",
)

# Define the models and relationships
class Car < ActiveRecord::Base
  has_many :transactionns
end

class Customer < ActiveRecord::Base
  has_many :transactionn
  has_many :car, through: :transactionns
end

class Transactionn < ActiveRecord::Base
  self.table_name = "transactions"

  belongs_to :car
  belongs_to :customer

  # p Transactionn.car
  def total()
    (self.car.cost_price + (1 + (self.car.sale_markup / 100))) * 1.088
  end
end

# Everytime the script is run it clears the database, this
# is okay while working on carson's request.
Transactionn.destroy_all
Car.destroy_all
Customer.destroy_all

# Create a few records...
# or import that CSV and create the appropriate records off of it.
CSV.foreach("./CAR_DATA.csv") do |row|
  id = row[0]
  first_name = row[1]
  last_name = row[2]
  email = row[3]
  gender = row[4]
  phone_number = row[5]
  car_make = row[6]
  car_model = row[7]
  car_year = row[8]
  cost_price = row[9]
  sale_markup = row[10]

  new_customer = Customer.create(
    id: id,
    first_name: first_name,
    last_name: last_name,
    email: email,
    gender: gender,
    phone_numer: phone_number,

  )
  new_car = Car.create(
    id: id,
    make: car_make,
    model: car_model,
    # car_year: car_year,
    cost_price: cost_price,
    sale_markup: sale_markup,
    customer_id: id,
  )
  Transactionn.create(
    customer_id: new_customer.id,
    car_id: new_car.id,
  )
end
# to let you use the terminal to CRUD the database.

# transaction = Transactionn.first
binding.pry
