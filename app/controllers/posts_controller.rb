# XXX: Where does UUID generation sit?

class PostsController < ApplicationController
  def index
    @posts = PostReport.posts
  end

  def new
    @command = CreatePostCommand.new
  end

  def create
    @command = CreatePostCommand.new({ id: uuid }.merge(params[:command]))

    EventBus.send_command @command

    redirect_to action: :show, id: @command.id
  end

  def show
    @post = PostReport.post_with_id params[:id]
    @comment_command = CreateCommentCommand.new
  end

  def edit
    @post = CommandHandlers.repository.get Post, params[:id]
    @command = UpdatePostCommand.new id: @post.id, original_version: @post.version,
      title: @post.title, body: @post.body
  end

  def update
    @command = UpdatePostCommand.new({ id: params[:id] }.merge(params[:command]))
    @command.original_version = @command.original_version.to_i

    EventBus.send_command @command

    redirect_to action: :show, id: @command.id
  end
end
