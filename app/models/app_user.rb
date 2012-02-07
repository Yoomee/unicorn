class AppUser < ActiveRecord::Base
  has_many :api_call_logs
end