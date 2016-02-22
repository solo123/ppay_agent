module Biz
  class ParseExcelBiz < AdminBiz
    def main_job
      return if $redis.get(@@flag_name) == 'running'
      $redis.set(@@flag_name, 'running')
      @parent_log = log "导入已下载的excel文件数据。"
      ImpLog.where(status: 1).each do |l|
        import_data(l)
      end
      $redis.set(@@flag_name, '')
    end

    def import_data(implog)
      if implog.status == 8
        log "该日数据已经从excel中导入。"
        return
      end
      data_file = "tmp/qf_xls/#{implog.uid}.xls"
      log "数据文件：" + data_file
      unless implog.status == 1 && File.exists?(data_file)
        implog.status = 0
        implog.save
        log "imp_log中状态不对，或文件[#{data_file}]不存在。"
        return
      end

      begin
        book = Spreadsheet.open data_file
      rescue => e
        implog.detail << '[无法打开文件]' << e.message
        implog.status = '0'
        implog.save
        book = nil
        log "无法打开excel文件", e.message
      ensure
      end

      if book
        implog.detail << '[格式正确]'
      else
        return
      end

      begin
        import_qf_clients(book, implog)
        import_qf_trades(book, implog)
        import_qf_clearing(book, implog)
        implog.status = '8'
      rescue => e
        implog.detail << '[文件解析出错]' << e.message
        implog.status = 0
        log "excel文件解析出错！", e.message
      ensure
      end
      implog.save
    end


    def import_qf_clients(xsl_file, implog)
      attrs = []
      if implog.received_at < '2016-01-20'
        attrs = ['shid', 'hylx', 'dm', 'lxr', 'sj', 'rwsj', 'sf', 'cs', 'dz', 'ywy', 'fl', 'zdcm', 'jjkdbxe', 'jjkdyxe', 'xykdbxe', 'xykdyxe']
      else
        attrs = ['shid', 'hylx', 'dm', 'lxr', 'sj', 'rwsj', 'sf', 'cs', 'dz', 'ywy', 'shzt', 'fl', 'zdcm', 'jjkdbxe', 'jjkdyxe', 'xykdbxe', 'xykdyxe']
      end
      cnt = 0
      sheet = xsl_file.worksheet 0
      sheet.each do |row|
        next if row[1].nil? || row[1].to_i < 1

        imp = implog.imp_qf_customers.build
        attrs.each_with_index do |att, idx|
          imp[att] = row[idx + 1]
        end
        imp.save
        cnt += 1
      end
      implog.detail << '商户资料:' + cnt.to_s + ', '
      log "导入商户资料[#{cnt}]条"
    end

    def import_qf_trades(xsl_file, implog)
      attrs = ['shid', 'zzh', 'jyrq', 'jylx', 'jyjg', 'jye', 'zdcm', 'zt']

      cnt = 0
      sheet = xsl_file.worksheet 1
      sheet.each do |row|
        next if row[1].nil? || row[1].to_i < 1
        imp = implog.imp_qf_trades.build
        attrs.each_with_index do |att, idx|
          imp[att] = row[idx + 1]
        end
        if row[3].is_a? DateTime
          imp.jyrq = row[3].change(offset: "+0800")
        end
        imp.save
        cnt += 1
      end
      implog.detail << "交易:#{cnt}, "
      log "导入交易数据[#{cnt}]条"
    end

    def import_qf_clearing(xsl_file, implog)
      attrs = ['shid', 'qsrq', 'jybs', 'jybj', 'sxf', 'jsje', 'sjqsje', 'qszt', 'zt']

      cnt = 0
      sheet = xsl_file.worksheet 2
      sheet.each do |row|
        next if row[1].nil? || row[1].to_i < 1

        imp = implog.imp_qf_clearings.build
        attrs.each_with_index do |att, idx|
          imp[att] = row[idx + 1]
        end
        imp.save
        cnt += 1
      end
      implog.detail << "清算:#{cnt}"
      log "导入清算数据[#{cnt}]条"
    end
  end
end
