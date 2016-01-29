class NoticesController < ApplicationController

  def index
    d = DateTime.now
    @collection = Notice.where("publish_date < ? AND close_date> ?", d, d).page( params[:page]).per(10)
  end

  def show
    @object = Notice.find(params[:id])
  end

end
