# Use this file to easily define all of your cron jobs.
set :output, File.expand_path(File.dirname(__FILE__) + "/../log/cron.log")

every 5.minutes do
  rake "venues:refresh"
end

every 1.minute do
  rake "unicorn:move"
end