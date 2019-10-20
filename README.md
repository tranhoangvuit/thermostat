# README
This project build on Ruby On Rails : 5.2.1 and Ruby: 2.5.1, Sqlite.

# SETUP
To inilize this project, follow this step:
 - Create new database: `rails db:create`
 - Create new tables: `rails db:migrate`
 - Seed example data: `rails db:seed`

# RUN PROJECT
We can run this project with two way:
 - First way: We run two separate command on two window of terminal:
 `rails s` and `bundle exec sidkiq -C configs/sidekiq`
 - Second way: We install foreman from `https://github.com/ddollar/foreman`. After that rerun with `foreman start`. Default port will be 5000.