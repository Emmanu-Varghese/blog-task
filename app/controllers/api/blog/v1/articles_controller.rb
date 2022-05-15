module Api
  module Blog
    module V1
      # :nodoc:
      class ArticlesController < ApplicationController
        protect_from_forgery with: :null_session, if: proc { |c| c.request.format.json? }
        before_action :verify_and_set_user
        before_action :verify_and_set_article, only: %i[show update destroy]

        # GET /articles
        def index
          render json: @user.articles, each_serializer: ArticleSerializer
        end

        # GET /articles/1
        def show
          render json: @article
        end

        # POST /articles
        def create
          @article = Article.new(article_params)

          if @article.save
            render json: @article, status: :created, location: @article
          else
            render json: @article.errors, status: :unprocessable_entity
          end
        end

        # PATCH/PUT /articles/1
        def update
          if @article.update(article_params)
            render json: @article
          else
            render json: @article.errors, status: :unprocessable_entity
          end
        end

        # DELETE /articles/1
        def destroy
          @article.destroy
        end

        private

        def verify_and_set_user
          @user = User.find_by(id: params[:user_id].to_i)
          return true unless @user.nil?

          head :not_found
        end

        # Use callbacks to share common setup or constraints between actions.
        def verify_and_set_article
          @article = Article.find_by(id: params[:id], user_id: @user.id)
          return true unless @article.nil?

          head :not_found
        end

        # Only allow a list of trusted parameters through.
        def article_params
          params.require(:article).permit(:title, :body, :user_id)
        end
      end
    end
  end
end
