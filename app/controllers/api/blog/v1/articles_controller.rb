module Api
  module Blog
    module V1
      # :nodoc:
      class ArticlesController < ApplicationController
        before_action :verify_and_set_article, only: %i[show update destroy]

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

        # Use callbacks to share common setup or constraints between actions.
        def verify_and_set_article
          @article = Article.find_by(id: params[:id])
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
