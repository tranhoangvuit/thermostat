namespace :cache do

  desc 'Clear all cache on rails cache'
  task clear: :environment do
    Object.const_set "RAILS_CACHE", ActiveSupport::Cache.lookup_store(Rails.configuration.cache_store)
    Rails.cache.clear
    puts "Cleared cache"
  end

end