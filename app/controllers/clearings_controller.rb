class ClearingsController < ResourceController
  def initialize
    super
    @m_fields = [1, 3, 4]
    @sum_fields = [1, 2]

    @table_head = '导入数据结果'
    @field_titles = ['', '清算日期', '交易笔数', '交易金额','交易手续费', '结算金额', '清算金额', '清算状态', '处理状态']
  end
end
