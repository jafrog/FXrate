require 'FXrate'
require 'active_record_storage'

namespace :fxrates do
  desc "Updates Foreign Exchange rates"
  task :update => :environment do
    FXrate.setup :storage => ActiveRecordStorage.new
    FXrate.update
  end
end
