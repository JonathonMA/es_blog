CreatePostCommand = ActiveModel(:id, :title, :body) do
  validates :title, :body, presence: true
end
