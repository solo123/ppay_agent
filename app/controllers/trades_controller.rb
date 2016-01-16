class TradesController < ResourceController
  def initialize
    super
    @m_fields = [1, 3, 4]
    @sum_fields = [1, 2]

    @table_head = '导入数据结果'
    @field_titles = [ '', '', '',  '交易日期', '交易结果', '交易量', '交易状态', '处理状态' ]
  end

  def load_collection
    agent_total  = Biz::AgentTotalBiz.new(current_user.agent.id)

    params[:q] ||= {}
    params[:all_query] ||= ''

    search_key = params[:q]

    if !params[:all_query].to_s.empty?
      search_key  =  {'m'=>'or'}
      search_key["trade_amount_eq"] = params[:all_query].to_f
      search_key["trade_date"] = params[:all_query].to_date || Date.current
    end
    @q = agent_total.trades_all.ransack( search_key )

    @collection = @q.result(distinct: true).page(params[:page]).per( 100 )
  end

end
