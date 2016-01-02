class PosMachinesController < ResourceController
  def initialize
    super
    @m_fields = [1, 3, 4]
    @sum_fields = [1, 2]

    @table_head = '导入ueo结果'
    @field_titles = [ '邮件ID', '邮件标题', '接收时间', '发件人', '统计', '状态' ]
  end



end
