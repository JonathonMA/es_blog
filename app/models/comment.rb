class Comment < AggregateRoot
  def initialize(id = nil, post_id = nil, body = nil)
    super()
    if id
      apply_change CommentCreated.new(id, post_id, body)
    end
  end

  attr_reader :post_id, :body, :active

  def delete
    apply_change CommentDeleted.new(id)
  end

  def on_comment_created(e)
    @id = e.id
    @post_id = e.post_id
    @body = e.body
  end

  def on_comment_deleted(e)
    @active = false
  end
end
