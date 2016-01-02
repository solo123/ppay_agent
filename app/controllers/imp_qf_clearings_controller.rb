class ImpQfClearingsController < ResourceController
  def initialize
    super
    @m_fields = [2, 3, 4, 5, 6]
    @sum_fields = [3, 4, 5]

    @table_head = '清算数据'
    @field_titles = [ '商户id', '清算日期', '交易笔数', '交易本金', '手续费', '结算金额', '实际清算金额', '状态' ]
  end
end
