module Api
  module Blog
    module V1
      # :nodoc:
      class CommentsController < ApplicationController
        before_action :verify_and_set_article
        before_action :verify_and_set_comment, except: %i[index create]

        # GET /comments
        def index
          render json: @article.comments, each_serializer: CommentSerializer
        end

        # POST /comments
        def create
          @comment = @article.comments.new(comment_params)

          if @comment.save
            render json: @comment, status: :created, location: @comment
          else
            render json: @comment.errors, status: :unprocessable_entity
          end
        end

        # PATCH/PUT /comments/1
        def update
          if @comment.update(comment_params)
            render json: @comment
          else
            render json: @comment.errors, status: :unprocessable_entity
          end
        end

        # DELETE /comments/1
        def destroy
          @comment.destroy
        end

        def add_emote
          @user = User.find_by(id: params[:user_id])
          head :unprocessable_entity and return if @user.nil?

          emote = @user.emotes.find_or_initialize_by(comment: @comment, emoji: params[:emote])
          emote.save and @comment.touch if emote.new_record?
          head :ok
        end

        def remove_emote
          @user = User.find_by(id: params[:user_id])
          head :unprocessable_entity and return if @user.nil?

          emote = @user.emotes.find_by(comment: @comment, emoji: params[:emote])
          emote&.destroy
          @comment.touch
          head :ok
        end

        private

        # Use callbacks to share common setup or constraints between actions.
        def verify_and_set_comment
          @comment = Comment.find_by(id: params[:id])
          return true unless @comment.nil?

          render json: "Comment not found", status: :unprocessable_entity
        end

        # Only allow a list of trusted parameters through.
        def comment_params
          params.require(:comment).permit(:user_id, :body, :commentable_id, :commentable_type)
        end

        def verify_and_set_article
          @article = Article.find_by(id: params[:article_id])
          return true unless @article.nil?

          render json: "Article not found", status: :unprocessable_entity
        end
      end
    end
  end
end
