module Api
  module Blog
    module V1
      # :nodoc:
      class UsersController < ApplicationController
        before_action :verify_and_set_user

        # GET /articles
        def articles
          render json: @user.articles, each_serializer: ArticleSerializer
        end

        private

        def verify_and_set_user
          @user = User.find_by(id: params[:id].to_i)
          return true unless @user.nil?

          render json: "User not found", status: :unprocessable_entity
        end
      end
    end
  end
end
