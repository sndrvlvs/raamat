# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
Account.create([
  {name: 'Cash', a_type: 'assets'}, 
  {name: 'Bank', a_type: 'assets'}, 
  {name: 'Revenue', a_type: 'revenue'}, 
  {name: 'Liabilities', a_type: 'liabilities'}, 
  {name: 'Expenses', a_type: 'expenses'}, 
  {name: 'Equity', a_type: 'equity'}
])
User.create!(:name => 'admin', :email => 'admin@localhost', :password => '123123', :role => 'admin')