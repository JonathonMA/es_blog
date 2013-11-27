%w(
  aggregate_root
  bus
  event_bus
  event_listener
  hash_event_store
  repository
).each do |file|
  require_relative "infrastructure/#{file}"
end
