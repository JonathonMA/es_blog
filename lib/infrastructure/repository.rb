class Repository
  def initialize(storage = HashEventStore.new(EventBus))
    @storage = storage
  end

  def save(aggregate, expected_version)
    @storage.save_events aggregate.id,
                         aggregate.uncommitted_changes,
                         expected_version
  end

  def get(klass, id)
    obj = klass.new

    obj.instance_variable_set :@id, id
    obj.load_from_history @storage.get_events_for_aggregate(id)

    obj
  end
end
