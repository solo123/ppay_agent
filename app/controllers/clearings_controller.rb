class ClearingsController < ResourceController
  def initialize
    super
    @m_fields = [1, 3, 4]
    @sum_fields = [1, 2]

    @table_head = '导入数据结果'
    @field_titles = ['', '清算日期', '交易笔数', '交易金额','交易手续费', '结算金额', '清算金额', '清算状态', '处理状态']
  end


  def load_collection
    agent_total  = Biz::AgentTotalBiz.new(current_user.agent.id)

    params[:q] ||= {}
    params[:all_query] ||= ''

    search_key = params[:q]
    if !params[:all_query].to_s.empty?
      search_key  =  {'m'=>'or'}
      # tmp["trade_amount_eq"] = params[:all_query].to_f
      # tmp["trade_date"] = params[:all_query].to_date || Date.current
    end
    @q = agent_total.clearings_all.ransack( search_key )

    @collection = @q.result(distinct: true).page(params[:page]).per( 100 )
  end


end
