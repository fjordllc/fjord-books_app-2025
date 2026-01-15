# frozen_string_literal: true

class CommentsController < ApplicationController
  before_action :set_comment, only: %i[show edit update destroy]
  before_action :set_commentable, only: %i[create]

  def show; end

  def new
    @comment = Comment.new
  end

  def edit; end

  def update; end

  def destroy; end

  def create
    @comment = @commentable.comments.new(comment_params)
    @comment.user = current_user
    @comment.save!

    redirect_to @commentable, notice: t('controllers.common.notice_create', name: Comment.model_name.human)
  end

  private

  def comment_params
    params.expect(comment: %i[body])
  end

  def set_comment
    @comment = @commentable.find(params.expect(:id))
  end

  def set_commentable
    if params[:report_id]
      @commentable = Report.find(params[:report_id])
    elsif params[:book_id]
      @commentable = Book.find(params[:book_id])
    else
      raise ActionController::RoutingError, 'Not Found'
    end
  end
end
