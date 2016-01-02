class AddressesController < ResourceController
  def initialize
    super
    @m_fields = [1, 3, 4]
    @sum_fields = [1, 2]

    @table_head = '导入数据结果'
    @field_titles = ['省', '市', '地址', '邮编', '状态']
  end

end
