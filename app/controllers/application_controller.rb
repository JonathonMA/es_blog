# XXX: Need to load all event types before loading event
# store
CommentCreated
PostCreated
PostUpdated

class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  private

  before_filter :load_event_storage
  after_filter :persist_event_storage

  def uuid
    SecureRandom.uuid
  end

  EVENT_HASH_LOCATION = Rails.root.join "tmp", "events.yml"

  def load_event_storage
    CommandHandlers.repository = Repository.new HashEventStore.new(EventBus, persisted_event_hash)
    # XXX: Listner needs to be loaded all the time and stuff.
    BullShitDatabase.clear
    PostReport.private_replay(CommandHandlers.repository)
  end

  def persist_event_storage
    File.open(EVENT_HASH_LOCATION, 'w') do |io|
      YAML.dump CommandHandlers.repository.storage.current, io
    end
  end

  def persisted_event_hash
    YAML.load IO.read EVENT_HASH_LOCATION
  rescue
    {}
  end
end
