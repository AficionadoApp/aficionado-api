class PostsController < ApplicationController
  before_filter :find_piece

  def create
    post = @piece.posts.build(
      comment: params[:comment],
      name: params[:name],
      accession_number: @piece.accession_number,
    )
    if post.save
      render json: { ok: true }, status: 201
    else
      render json: { ok: false }, status: 400
    end
  end

  private

  def find_piece
    @piece = Piece.where(accession_number: params[:accession_number]).first_or_create
  end

  def post_params
    params.require(:post).permit(:name, :comment, :accession_number)
  end
end
