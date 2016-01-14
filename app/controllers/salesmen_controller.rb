class SalesmenController < ApplicationController
  def initialize
    super
    @table_head = '业务员资料'
    @fields = %w(name)
    @field_titles = [ '姓名' ]
  end

  def show
    @object = Salesman.find(params[:id])

  end

  def index
    params[:q] ||= {}
    params[:all_query] ||= ''
    if params[:all_query].to_s.empty?
    else
      @q = current_user.agent.salesman_all.ransack( params[:q] )
    end
    @collection = @q.result(distinct: true).page(params[:page])
  end

end
