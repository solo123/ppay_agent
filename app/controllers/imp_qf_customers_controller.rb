class ImpQfCustomersController < ResourceController
  def initialize
    super
    @m_fields = [6, 9, 12]
    @sum_fields = []

    @table_head = '商户数据'
    @field_titles = [ '商户id', '用户类型', '商家名称', '联系人', '入网电话', '入网时间', '省份', '城市', '地址', '业务员', '费率', '绑定机器编码', '借记卡单笔限额', '借记卡单月限额', '信用卡单笔限额', '信用卡单月限额', '状态', 'log' ]
  end
end
