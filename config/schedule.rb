# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
set :output, File.expand_path(File.dirname(__FILE__) + "/../log/cron.log")


every 5.minutes do
  rake "venues:refresh"
end

every 30.minutes do
  rake "unicorn:move"
end
#
# every 4.days do
#   runner "AnotherModel.prune_old_records"
# end

# Learn more: http://github.com/javan/whenever
