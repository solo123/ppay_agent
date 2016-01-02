class TradesController < ResourceController
  def initialize
    super
    @m_fields = [1, 3, 4]
    @sum_fields = [1, 2]

    @table_head = '导入数据结果'
    @field_titles = [ '', '', '',  '交易日期', '交易结果', '交易量', '交易状态', '处理状态' ]
  end
end
