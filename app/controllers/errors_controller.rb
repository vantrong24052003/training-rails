class ErrorsController < ApplicationController
  layout "error"

  def not_found
    respond_to do |format|
      format.html { render status: 404 }
      format.json { render json: { error: "Resource not found" }, status: 404 }
    end
  end
end
