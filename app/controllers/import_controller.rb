class ImportController < ApplicationController
  def do_import
    if $redis.get(:qf_imp_flag) == 'running'
      @import_status = 0
      flash[:errors] ||= []
      flash[:errors] << "[取消] 在上次导入结束前，不能重复进行导入。"
    else
      @import_status = 1
      $redis.lpush :import_log, "0. 准备导入数据..."
      ImportDataJob.perform_later nil
    end
  end

  def parse_data
    if $redis.get(:parse_data_flag) == 'running'
      flash[:error] ||= []
      flash[:error] << "[取消] 在上次解析数据结束前，不能重复解析数据。"
    else
      $redis.lpush :parse_log, "0. 准备解析数据..."
      ParseDataJob.perform_later nil
    end
  end

  def get_import_msg
    r = ""
    while (msg = $redis.rpop(:import_log))
      r << "<p>#{msg}</p>"
    end
    render :text =>  r.html_safe
  end

  def get_log_msg
    log_name = params[:log_name]
    r = []
    while (msg = $redis.rpop(log_name))
      r << msg
    end
    render text: r.join('|').html_safe
  end

  def pre_process
    logger.info 'start pre process the raw data'
    ProcessForAgentJob.perform_later nil

    redirect_to root_path
  end
end
