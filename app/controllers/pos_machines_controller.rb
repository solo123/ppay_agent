class PosMachinesController < ApplicationController
  def initialize
    super
    @field_titles = [ '邮件ID', '邮件标题', '接收时间', '发件人', '统计', '状态' ]
  end

end
