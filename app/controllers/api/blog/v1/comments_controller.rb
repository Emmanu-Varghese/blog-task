module Api
  module Blog
    module V1
      # :nodoc:
      class CommentsController < ApplicationController
        protect_from_forgery with: :null_session, if: proc { |c| c.request.format.json? }

        before_action :verify_and_set_params
        before_action :verify_and_set_comment, except: %i[index create]

        # GET /comments
        def index
          render json: @article.comments, each_serializer: CommentSerializer
        end

        # POST /comments
        def create
          @comment = @article.comments.new(comment_params)

          if @comment.save
            render json: @comment, status: :created, location: article_comment_url(@article, @comment)
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
          @user = User.find_by(id: params[:reacting_user_id])
          head :not_found and return if @user.nil?

          emote = @user.emotes.find_or_initialize_by(comment: @comment, emoji: "#{params[:emote]}.png")
          emote.save and @comment.touch if emote.new_record?
          head :ok
        end

        def remove_emote
          @user = User.find_by(id: params[:reacting_user_id])
          head :not_found and return if @user.nil?

          emote = @user.emotes.find_by(comment: @comment, emoji: "#{params[:emote]}.png")
          emote&.destroy
          @comment.touch
          head :ok
        end

        private

        def verify_and_set_params
          @user = User.find_by(id: params[:user_id].to_i)
          head :not_found and return if @user.nil?

          @article = Article.find_by(id: params[:article_id], user_id: @user.id)
          head :not_found and return if @article.nil?
        end

        # Use callbacks to share common setup or constraints between actions.
        def verify_and_set_comment
          @comment = Comment.find_by(id: params[:id], article_id: @article.id)
          return true unless @comment.nil?

          head :not_found
        end

        # Only allow a list of trusted parameters through.
        def comment_params
          params.require(:comment).permit(:user_id, :body, :user_id)
        end
      end
    end
  end
end
