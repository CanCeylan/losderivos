# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


Client.create({name: "Zara", branch:"Istinye Park"})
Client.create({name: "Zara", branch:"Kanyon"})
Client.create({name: "Zara", branch:"Marmaris Marina"})

Location.create({client_id: 1, region: "Outside South", minX: -0.5, maxX: 190, minY: -0.5, maxY: 20, isOutside: true})
Location.create({client_id: 1, region: "Outside West", minX: -0.5, maxX: 25, minY: -0.5, maxY: 105, isOutside: true})
Location.create({client_id: 1, region: "Women", minX: 25, maxX: 120, minY: 60, maxY: 105, isOutside: false})
Location.create({client_id: 1, region: "Men", minX: 120, maxX: 190, minY: 20, maxY: 60, isOutside: false})
Location.create({client_id: 1, region: "All", minX: 25, maxX: 120, minY: 20, maxY: 60, isOutside: false})
Location.create({client_id: 1, region: "Checkout", minX: 120, maxX: 190, minY: 60, maxY: 105, isOutside: false})


