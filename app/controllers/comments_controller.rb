class CommentsController < ApplicationController
  load_and_authorize_resource
  before_action :set_article
  before_action :set_comment, only: %i[edit update destroy]

  # GET /comments/1 or /comments/1.json
  def show; end

  # GET /comments/new
  def new
    @comment = Comment.new
  end

  # GET /comments/1/edit
  def edit; end

  # POST /comments or /comments.json
  def create
    @comment = @article.comments.new(comment_params.merge(user_id: current_user.id))
    respond_to do |format|
      if @comment.save
        format.html { redirect_to article_comments_url(@article), notice: "Comment was successfully created." }
        format.json { render :show, status: :created, location: @comment }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
      format.js { render layout: false }
    end
  end

  # PATCH/PUT /comments/1 or /comments/1.json
  def update
    respond_to do |format|
      if @comment.update(comment_params)
        format.html { redirect_to article_comments_url(@article), notice: "Comment was successfully updated." }
        format.json { render :show, status: :ok, location: @comment }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
      format.js { render layout: false }
    end
  end

  # DELETE /comments/1 or /comments/1.json
  def destroy
    @comment.destroy

    respond_to do |format|
      format.html { redirect_to article_comments_url(@article), notice: "Comment was successfully destroyed." }
      format.json { head :no_content }
      format.js { render layout: false }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_article
    @article = Article.find_by(id: params[:article_id])
  end

  def set_comment
    @comment = Comment.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def comment_params
    params.require(:comment).permit(:article_id, :user_id, :body)
  end
end
