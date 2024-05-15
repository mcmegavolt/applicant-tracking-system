class JobsController < ApplicationController
  before_action :authenticate_user!

  def index
    result = JobsWithStats.call
    serialized_data = JobSerializer.new(result, is_collection: true).serializable_hash

    render json: serialized_data
  end
end
