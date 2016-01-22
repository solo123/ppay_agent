class BulletinBoardSystemsController < ApplicationController
  def index
    @collection = BulletinBoardSystem
            .where("deadtime > ?", Date.current).order("updated_at desc")
            .page( params[:page] ).per(20)
  end

  def show
    @object = BulletinBoardSystem.find(params[:id])
    # if @object.deadtime < Date.current
    #   @bbs_warn = "无效通告"
    # end
  end

end
