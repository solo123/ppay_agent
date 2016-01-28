class NoticesController < ApplicationController

  def index
    @collection = Notice.page( params[:page]).per(10)
  end

  def show
    @object = Notice.find(params[:id])
  end

end
