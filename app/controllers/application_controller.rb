class ApplicationController < ActionController::API
  include Pagy::Backend

  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  def pagy_metadata(pagy)
    {
      page: pagy.page,
      per_page: pagy.limit,
      total_pages: pagy.pages,
      total_count: pagy.count
    }
  end

  private

  def record_not_found(exception)
    render json: { error: "#{exception.model} não encontrado" }, status: :not_found
  end
end
