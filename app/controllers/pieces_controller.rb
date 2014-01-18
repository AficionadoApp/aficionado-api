class PiecesController < ApplicationController

  def index
    piece = Piece.where(accession_number: params[:accession_number]).first_or_create
    render json: piece.full_details_hash
  end

end