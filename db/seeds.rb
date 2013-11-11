# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Friendship.delete_all
Topic.delete_all
Member.delete_all

members = []
david = {name: 'David Heinemeier Hansson', website: 'http://david.heinemeierhansson.com/'}
members << david
jason = {name: 'Jason Fried', website: 'https://twitter.com/jasonfried'}
members << jason

members << {name: 'Alan', website: 'http://www.alphasights.com/careers/positions/london/ruby-on-rails-developer'}
members << {name: 'Oliver', website: 'https://github.com/oliver'}
members << {name: 'Ernie Miller', website: 'http://erniemiller.org/'}

members << {name: 'Dmitry Gruzd', website: 'https://github.com/nyaa'}

members.each{|m| Member.create!(m) }

arr = Member.where(:name => [david[:name], jason[:name]]).map(&:id).sort
Friendship.create!(member_id: arr.first, friend_id: arr.last)