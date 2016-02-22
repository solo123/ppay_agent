module Biz
  class GetQfEmailsBiz < AdminBiz
    def main_job
      return if $redis.get(@@flag_name) == 'running'
      $redis.set(@@flag_name, 'running')
      @parent_log = log "从email中导入数据"
      begin
        import_from_email_unsafe
      rescue Exception => e
        log '读取邮件出错:' + e.message, e.backtrace.inspect
      ensure
        $redis.set(@@flag_name, '')
        log '[job_end] 读取QF邮件结束.'
      end
    end

    def import_from_email_unsafe
      require "net/imap"

      get_new_emails.each do |uid|
        slog uid
        if ImpLog.where('status>0').find_by(uid: uid)
          log ":h1 重复邮件[#{uid}]"
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
            log "附件下载成功"
          else
            implog.detail << '[没有附件]'
            implog.status = 1
            log "没有附件。"
          end
        end
        implog.save
      end
    end

    def get_new_emails
      @email = 'qfqpos@pooul.cn'
      @email_pass = 'caI1111'
      @imap = Net::IMAP.new 'imap.qq.com', 993, true, nil, false
      @imap.login(@email, @email_pass)
      @imap.select('inbox')

      since_time = "30-Nov-2014"
      if l = ImpLog.where('status>0').last
        since_time = Net::IMAP.format_datetime(l.received_at.to_date) if l.received_at
      end
      log "读取日期#{since_time}之后的新邮件"
      @imap.search( ["SINCE", since_time ])
    end

    def check_email(uid, implog)
      body = @imap.fetch(uid, "RFC822")[0].attr["RFC822"]
      mail = Mail.new(body)
      implog.title = mail.subject
      implog.received_at = mail.date
      implog.mail_from = mail.from.kind_of?(Array) ? mail.from.join(',') : mail.from
      log "邮件：#{implog.title}，来自：#{implog.mail_from} @ #{implog.received_at}"
      mail.has_attachments?
    end

    def get_attchement(uid)
      attachment = @imap.fetch(uid, "BODY[2]")[0].attr["BODY[2]"]
    end


  end
end
