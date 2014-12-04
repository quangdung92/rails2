# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
user = User.create(:user_id => '1992111-1234', :password=> 'sa1234',
:name => 'quangdung', :uid=> '0000000000002',
:shop_no => '2406')

if user.errors.blank?
  puts "***User #{user.name} #{user.password} created ***"
else
  puts "user failed to create due to below reasons:"
  user.errors.each do |x, y|
    puts"***#{x} #{y}***" # x will be the field name and y will be the error on it
  end
end

user = User.login("1992112-1234","112113")
if user
  puts "***User #{user.user_id} #{user.password} logged in ***"
else
  puts "***User does not exist! ***"
end