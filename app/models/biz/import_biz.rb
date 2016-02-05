module Biz
  class ImportBiz
    attr_accessor :errors
    def import_from_email
      return if $redis.get(:qf_imp_flag) == 'running'
      $redis.set(:qf_imp_flag, 'running')

      slog ":h1 开始读取邮件......"
      begin
        import_from_email_unsafe
      rescue Exception => e
        slog ':h1 读取邮件出错！！'
        slog e.message
        slog e.backtrace.inspect
      ensure
        $redis.set(:qf_imp_flag, '')
        slog ':h1 导入结束...'
        slog 'import_end'
      end
    end

    def import_from_email_unsafe
      require "net/imap"

      get_new_emails.each do |uid|
        slog uid
        if ImpLog.where('status>0').find_by(uid: uid)
          slog ":h1 重复邮件[#{uid}]"
          next
        end
        implog = ImpLog.find_or_create_by(uid: uid.to_i, status: 0)
        implog.save
        if check_email(uid, implog)
          att = get_attchement(uid)
          if att
            dir_name = 'tmp/qf_xls'
            file_name = "#{uid}.xls"
            FileUtils.mkdir_p(dir_name) unless File.directory?(dir_name)
            File.new("#{dir_name}/#{file_name}", 'wb+').write(att.unpack('m')[0] )
            implog.detail << '[附件下载ok]'
            implog.status = 1
            slog "    附件下载成功"
          else
            implog.detail << '[没有附件]'
            implog.status = 1
            slog "    没有附件。"
          end
        end
        implog.save
      end
    end

    def get_new_emails
      slog "> 正在读取邮件."
      @email = 'qfqpos@pooul.cn'
      @email_pass = 'caI1111'
      @imap = Net::IMAP.new 'imap.qq.com', 993, true, nil, false
      @imap.login(@email, @email_pass)
      @imap.select('inbox')

      since_time = "30-Nov-2014"
      if l = ImpLog.where('status>0').last
        since_time = Net::IMAP.format_datetime(l.received_at.to_date) if l.received_at
      end
      slog "读取日期#{since_time}之后的新邮件"
      @imap.search( ["SINCE", since_time ])
    end

    def check_email(uid, log)
      body = @imap.fetch(uid, "RFC822")[0].attr["RFC822"]
      mail = Mail.new(body)
      log.title = mail.subject
      log.received_at = mail.date
      log.mail_from = mail.from.kind_of?(Array) ? mail.from.join(',') : mail.from
      slog ":h1 邮件：#{log.title}，来自：#{log.mail_from} @ #{log.received_at}"
      mail.has_attachments?
    end

    def get_attchement(id)
      attachment = @imap.fetch(id, "BODY[2]")[0].attr["BODY[2]"]
    end

    def import_data(log)
      @errors ||= []
      if log.status == 8
        @errors << "该日数据已经从excel中导入。"
        return
      end
      data_file = "tmp/qf_xls/#{log.uid}.xls"
      unless log.status == 1 && File.exists?(data_file)
        log.status = 0
        log.save
        @errors << "imp_log中状态不对，或对于excel文件不存在。"
        return
      end

      begin
        book = Spreadsheet.open data_file
      rescue => e
        log.detail << '[无法打开文件]' << e.message
        log.status = '0'
        log.save
        book = nil
        @errors << "无法打开excel文件：" + e.message
      ensure
      end

      if book
        log.detail << '[格式正确]'
      else
        return
      end

      begin
        import_qf_clients(book, log)
        import_qf_trades(book, log)
        import_qf_clearing(book, log)
        log.status = '8'
      rescue => e
        log.detail << '[文件解析出错]' << e.message
        log.status = 0
        @errors << "excel文件解析出错！"
      ensure
      end
      log.save
    end


    def import_qf_clients(xsl_file, log)
      attrs = []
      if log.received_at < '2016-01-20'
        attrs = ['shid', 'hylx', 'dm', 'lxr', 'sj', 'rwsj', 'sf', 'cs', 'dz', 'ywy', 'fl', 'zdcm', 'jjkdbxe', 'jjkdyxe', 'xykdbxe', 'xykdyxe']
      else
        attrs = ['shid', 'hylx', 'dm', 'lxr', 'sj', 'rwsj', 'sf', 'cs', 'dz', 'ywy', 'shzt', 'fl', 'zdcm', 'jjkdbxe', 'jjkdyxe', 'xykdbxe', 'xykdyxe']
      end
      cnt = 0
      sheet = xsl_file.worksheet 0
      sheet.each do |row|
        next if row[1].nil? || row[1].to_i < 1

        imp = log.imp_qf_customers.build
        attrs.each_with_index do |att, idx|
          imp[att] = row[idx + 1]
        end
        imp.save
        cnt += 1
      end

      log.detail << '商户资料:' + cnt.to_s + ', '
    end

    def import_qf_trades(xsl_file, log)
      attrs = ['shid', 'zzh', 'jyrq', 'jylx', 'jyjg', 'jye', 'zdcm', 'zt']

      cnt = 0
      sheet = xsl_file.worksheet 1
      sheet.each do |row|
        next if row[1].nil? || row[1].to_i < 1
        imp = log.imp_qf_trades.build
        attrs.each_with_index do |att, idx|
          imp[att] = row[idx + 1]
        end
        if row[3].is_a? DateTime
          imp.jyrq = row[3].change(offset: "+0800")
        end
        imp.save
        cnt += 1
      end
      log.detail << "交易:#{cnt}, "
    end

    def import_qf_clearing(xsl_file, log)
      attrs = ['shid', 'qsrq', 'jybs', 'jybj', 'sxf', 'jsje', 'sjqsje', 'qszt', 'zt']

      cnt = 0
      sheet = xsl_file.worksheet 2
      sheet.each do |row|
        next if row[1].nil? || row[1].to_i < 1

        imp = log.imp_qf_clearings.build
        attrs.each_with_index do |att, idx|
          imp[att] = row[idx + 1]
        end
        imp.save
        cnt += 1
      end
      log.detail << "清算:#{cnt}"
    end

    def slog(msg)
      #puts msg
      $redis.lpush(:import_log, msg)
    end

  end
end
