# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

members = []
members << {name: 'David Heinemeier Hansson', website: 'http://david.heinemeierhansson.com/'}
members << {name: 'Jason Fried', website: 'https://twitter.com/jasonfried'}

members << {name: 'Alan', website: 'http://www.alphasights.com/careers/positions/london/ruby-on-rails-developer'}
members << {name: 'Oliver', website: 'https://github.com/oliver'}
members << {name: 'Ernie Miller', website: 'http://erniemiller.org/'}

members << {name: 'Dmitry Gruzd', website: 'https://github.com/nyaa'}

members.each{|m| Member.create!(m) }
