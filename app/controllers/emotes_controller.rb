class EmotesController < ApplicationController
  load_and_authorize_resource
  def show
    comment = Comment.find_by(id: params[:comment_id])
    emote = current_user.emotes.find_or_initialize_by(comment: comment, emoji: params[:emote])
    if emote.new_record?
      emote.save
    else
      emote.destroy
    end
    comment.touch
  end
end
