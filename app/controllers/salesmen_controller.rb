class SalesmenController < ResourceController
  def initialize
    super
    @table_head = '业务员资料'
    @fields = %w(name)
    @field_titles = [ '姓名' ]
  end


end
