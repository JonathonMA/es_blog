class PostReport < EventListener
  PostSummary = Struct.new :id, :title
  PostDetail = Struct.new :id, :title, :body, :comments
  CommentView = Struct.new :id, :body

  on :post_created do |e|
    BullShitDatabase.list << PostSummary.new(e.id, e.title)
  end

  on :post_updated do |e|
    post = BullShitDatabase.list.find { |i| i.id == e.id }
    post.title = e.title
  end

  on :post_created do |e|
    BullShitDatabase.details[e.id] = PostDetail.new(e.id, e.title, e.body, [])
  end

  on :post_updated do |e|
    post = BullShitDatabase.details[e.id]
    post.title = e.title
    post.body = e.body
  end

  on :comment_created do |e|
    BullShitDatabase.details[e.post_id].comments << CommentView.new(e.id, e.body)
  end

  on :comment_deleted do |e|
    BullShitDatabase.details.each do |post_id, post|
      post.comments.delete_if { |c| c.id == e.id }
    end
  end

  def self.posts
    BullShitDatabase.list
  end

  def self.post_with_id id
    BullShitDatabase.details[id]
  end
end
