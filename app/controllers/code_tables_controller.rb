class CodeTablesController < ResourceController
  def index
    @parents = CodeTable.top_level
    if params[:e]
      @object = CodeTable.find(params[:e])
    else
      @object = CodeTable.new
    end
    if params[:p]
      @collection = CodeTable.childs(params[:p])
      @parent = CodeTable.find(params[:p])
    else
      @collection = []
      @parent = nil
    end
  end
end
