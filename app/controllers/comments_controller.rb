class CommentsController < ApplicationController
  def create
    @command = CreateCommentCommand.new({ id: uuid }.merge(params[:command]))

    EventBus.send_command @command

    redirect_to controller: :posts, action: :show, id: @command.post_id
  end

  def destroy
    @command = DestroyCommentCommand.new id: params[:id]
    # XXX: no
    @comment = CommandHandlers.repository.get Comment, params[:id]

    EventBus.send_command @command

    redirect_to controller: :posts, action: :show, id: @comment.post_id
  end
end
