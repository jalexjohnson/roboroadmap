# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.destroy_all
alex = User.create(name: 'Alex Johnson', email: 'alex.johnson@morningstar.com', password: 'test', permitted: true, admin: true)
peter = User.create(name: 'Peter Haller', email: 'peter.haller@morningstar.com', password: 'test', permitted: true)
sharon = User.create(name: 'Sharon Murphy', email: 'sharon.murphy@morningstar.com', password: 'test', permitted: true)

Project.destroy_all
dcf = Project.create(name: 'Direct Cloud Framework', user_id: alex.id)
rp = Project.create(name: 'Research Portal', user_id: peter.id)
k = Project.create(name: 'Knapsack', user_id: alex.id, capacity: 32)

Job.destroy_all
Job.create(name: "Dashboards", project_id: dcf.id)
Job.create(name: "New Global Navigation", project_id: dcf.id)
Job.create(name: "File Management", project_id: dcf.id)
Job.create(name: "MUI Migration", project_id: dcf.id)
Job.create(name: "Publications", project_id: rp.id)
Job.create(name: "Server Error Pages", project_id: rp.id)
Job.create(name: "Subscriptions", project_id: rp.id)
Job.create(name: "Videos", project_id: rp.id)
Job.create(name: "A", size: 3, project_id: k.id)
Job.create(name: "B", size: 4, project_id: k.id)
Job.create(name: "C", size: 8, project_id: k.id)
Job.create(name: "D", size: 10, project_id: k.id)
Job.create(name: "E", size: 15, project_id: k.id)
Job.create(name: "F", size: 20, project_id: k.id)
