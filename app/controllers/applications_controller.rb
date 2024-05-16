class ApplicationsController < ApplicationController
  before_action :authenticate_user!

  def index
    result = ApplicationsWithStats.call
    serialized_data = ApplicationSerializer.new(result, is_collection: true).serializable_hash

    render json: serialized_data
  end
end
