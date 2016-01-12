class SalesCommissionsController < NestedResourcesController
  def initialize
    super
    @m_fields = [1, 3, 4]
    @sum_fields = [1, 2]

    @table_head = '分润规则'
    @field_titles = ['类型', 'start', 'end']
  end

end
