class ImpQfTradesController < ResourceController
  def initialize
    super
    @m_fields = [2, 3, 4, 5]
    @sum_fields = [6]

    @table_head = '交易数据'
    @field_titles = [ '商户id', '子帐号', '交易日期', '交易类型', '交易结果', '交易额', '终端串码', '状态', '日志'  ]
  end
end
