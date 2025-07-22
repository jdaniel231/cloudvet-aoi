class ApplicationController < ActionController::API
  include Pagy::Backend

  def pagy_metadata(pagy)
    {
      page: pagy.page,
      per_page: pagy.limit,
      total_pages: pagy.pages,
      total_count: pagy.count
    }
  end
end
