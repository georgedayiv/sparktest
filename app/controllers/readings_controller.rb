class ReadingsController < ApplicationController

  def index
    @readings = Reading.paginate(:page => params[:page], :per_page => 24)
  end

end
