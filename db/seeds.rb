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
ActiveRecord::Base.connection().execute('alter sequence members_id_seq RESTART;')

dhh = Member.create! name: 'David Heinemeier Hansson', website: 'http://david.heinemeierhansson.com/'
jason = Member.create! name: 'Jason Fried', website: 'https://twitter.com/jasonfried'
alan = Member.create! name: 'Alan', website: 'http://www.alphasights.com/careers/positions/london/ruby-on-rails-developer'
oliver = Member.create! name: 'Oliver', website: 'https://github.com/oliver'
ernie = Member.create! name: 'Ernie Miller', website: 'http://erniemiller.org/'

dhh.add_friend(jason)
alan.add_friend(dhh)
jason.add_friend(oliver)
oliver.add_friend(ernie)


#1.upto(30).each do |i|
#  m = Member.create!(name: Faker::Name.name, website: 'http://ya.ru')
#  m.add_friend(Member.offset(Member.count-1).limit(1).first)
#end

#members_ids = Member.select(:id).map(&:id)
#members_ids_length = members_ids.count
#members_ids.each do |m|
#  3.times do
#    friend_id = members_ids[rand(members_ids_length-1)]
#    next if friend_id == m
#
#    ids = [m,friend_id].sort
#    Friendship.create!(member_id: ids.first, friend_id: ids.last)
#  end
#end

