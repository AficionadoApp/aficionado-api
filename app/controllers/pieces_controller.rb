class PiecesController < ApplicationController

  def index
    piece = Piece.where(person_params).first_or_create
    render json: piece.full_details_hash
  end

  private

  def person_params
    params.permit(:accession_number)
  end
end
