class CommandHandlers < EventListener
  class << self
    attr_accessor :repository
  end

  on :create_post_command do |c|
    post = Post.new c.id, c.title, c.body
    repository.save post, -1
  end

  on :update_post_command do |c|
    post = repository.get Post, c.id
    post.update c.title, c.body
    repository.save post, c.original_version
  end

  on :create_comment_command do |c|
    comment = Comment.new c.id, c.post_id, c.body
    repository.save comment, -1
  end

  on :destroy_comment_command do |c|
    comment = repository.get Comment, c.id
    comment.delete
    repository.save comment, comment.version
  end
end
