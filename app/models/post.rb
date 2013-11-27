class Post < AggregateRoot
  def initialize(id = nil, title = nil, body = nil)
    super()
    if id
      apply_change PostCreated.new(id, title, body)
    end
  end

  alias_method :to_param, :id

  attr_reader :title, :body

  def update title, body
    apply_change PostUpdated.new(id, title, body)
  end

  def on_post_created(e)
    @id = e.id
    @title = e.title
    @body = e.body
  end

  def on_post_updated(e)
    @title = e.title
    @body = e.body
  end
end
