module Biz
  class ParseDataBiz

    def reset
      ImpQfCustomer.update_all(zt: 0)
      ImpQfTrade.update_all(zt: 0)
      ImpQfClearing.update_all(zt: 0)
      Client.delete_all
      Trade.delete_all
      Clearing.delete_all
    end
    def parse_all
      $redis.set(:parse_data_flag, 'running')
      parse_customers
      parse_trades
      parse_clearings
      slog('import_end')
      $redis.set(:parse_data_flag, '')
    end
    def parse_customers
      slog(':h1 开始解析客户数据...')
      ImpQfCustomer.new_data.each do |c|
        parse_customer(c)
      end
      slog('客户数据解析完成')
    end
    def parse_customer(c)
      return if c.zt && c.zt > 0
      shid = c.shid.to_i
      if shid == 0
        c.zt = 7
        c.save
      else
        client = Client.find_or_create_by(shid: shid)
        client.shop_name = c.dm
        client.shop_tel = c.sj
        client.rate = c.fl
        client.join_date = c.rwsj
        client.bank_card_limit_each = c.jjkdbxe
        client.bank_card_limit_month = c.jjkdyxe
        client.credit_card_limit_each = c.xykdbxe
        client.credit_card_limit_month = c.xykdyxe
        client.category = CodeTable.find_code(:biz_catalog, c.hylx)
        if client.changed?
          client.save
          slog("更新资料：id:#{client.shid} - #{client.shop_name}")
        end
        client.address ||= client.build_address
        client.address.province = CodeTable.find_prov(c.sf)
        client.address.city = CodeTable.find_city(client.address.province.id, c.cs)
        client.address.street = c.dz
        client.address.addr_obj = client
        if client.address.new_record?
          slog "新增地址：#{client.address}"
        else
          if client.address.changed?
            slog "更新地址：[#{client.address.id}] #{client.address.changes}"
          end
        end
        client.address.save

        if c.lxr.nil? || c.lxr.strip.empty?
        else
          lxr = Contact.find_or_create_by(name: c.lxr, tel: c.sj)
          client.contacts << lxr
          client.main_contact = lxr
        end
        if c.ywy.nil? || c.ywy.empty?
          client.salesman = Salesman.find_or_create_by(name: 'pooul')
        else
          client.salesman = Salesman.find_or_create_by(name: c.ywy)
        end
        unless c.zdcm.nil? || c.zdcm.empty?
          pos = PosMachine.find_machine(c.zdcm)
          client.pos_machines << pos if pos
        end
        client.save
        c.zt = 1
        c.save
      end
    end

    def parse_trades
      slog(':h1 开始解析交易数据...')
      ImpQfTrade.new_data.each do |t|
        parse_trade(t)
      end
      slog('交易数据解析完成')
    end
    def parse_trade(t)
      return if t.zt && t.zt > 0
      shid = t.shid.to_i
      if shid > 0
        trade = Trade.new()
        trade.client = Client.find_by(shid: shid)
        trade.pos_machine = PosMachine.find_machine(t.zdcm)
        if trade.client
          trade.sub_account = t.zzh
          trade.trade_date = Time.zone.parse(t.jyrq)
          trade.trade_type = CodeTable.find_code('trade_type', t.jylx)
          trade.trade_result = CodeTable.find_code('trade_result', t.jyjg)
          trade.trade_amount = t.jye
          trade.status = 0
          trade.save
          t.zt = 1
          slog("#{t.shid} - #{t.jye} - #{t.jyrq}")
        else
          slog("没有找到此商户：[#{t.shid}]")
          t.zt = 7
        end
      else
        slog("没有商户ID [#{t.shid}]")
        t.zt = 7
      end
      t.save
    end
    def parse_clearings
      slog(':h1 开始解析清算数据...')
      ImpQfClearing.new_data.each do |c|
        parse_clearing(c)
      end
      slog('清算数据解析完成')
    end
    def parse_clearing(c)
      return if c.zt && c.zt > 0
      shid = c.shid.to_i
      if shid > 0
        clr = Clearing.new
        clr.client = Client.find_by(shid: shid)
        if clr.client
          clr.trade_date = c.qsrq
          clr.trade_count = c.jybs
          clr.trade_amount = c.jybj
          clr.trade_fee = c.sxf
          clr.clearing_amount = c.jsje
          clr.actual_amount = c.sjqsje
          clr.clearing_status = CodeTable.find_code('clearing_status', c.qszt)
          clr.status = 0
          clr.save
          slog("清算：#{c.shid} - #{c.sjqsje} - #{c.qsrq}")
          c.zt = 1
        else
          slog("商户ID没有找到：[#{c.shid}]")
          c.zt = 7
        end
      else
        slog("没有商户ID [#{c.shid}]")
        c.zt = 7
      end
      c.save
    end

    def slog(msg)
      #puts msg
      $redis.lpush(:parse_log, msg)
    end
  end
end
