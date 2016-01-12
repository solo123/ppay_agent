class HomeController < ApplicationController
  def index
    # redirect_to agent_path(current_user.agent)

    # @cur_trade_toal = current_user.agent.cur_trade_total

    # @total_amount  = ClientDayTradetotal.sum("total_amount")
    # @total_count  = ClientDayTradetotal.sum("total_count")
    # @new_clienter_count = Client.where("join_date"=> d.all_month).count
    # @clienter_count = Client.count
    #
    # @t0_amount = ClientDayTradetotal.where("trade_date"=> d.all_month).sum("t0_amount")
    # @t0_count = ClientDayTradetotal.where("trade_date"=> d.all_month).sum("t0_count")
    #
    # @wechat_amount = ClientDayTradetotal.where("trade_date"=> d.all_month).sum("wechat_amount")
    # @wechat_count = ClientDayTradetotal.where("trade_date"=> d.all_month).sum("wechat_count")

  end

  def profile

  end
end
