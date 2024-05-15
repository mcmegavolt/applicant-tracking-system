class ApplicationsController < ApplicationController
  def index
    render json: {
      status: {
        code: 200, message: 'To be implemented...'
      }
    }, status: :ok
  end
end
