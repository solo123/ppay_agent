module ApplicationHelper
  def page_title(title)
    title += " | " if title.present?
    title += "Pooul"
  end

  MOBILE_USER_AGENTS = 'palm|blackberry|nokia|phone|midp|mobi|symbian|chtml|ericsson|minimo|' \
                         'audiovox|motorola|samsung|telit|upg1|windows ce|ucweb|astel|plucker|' \
                         'x320|x240|j2me|sgh|portable|sprint|docomo|kddi|softbank|android|mmp|' \
                         'pdxgw|netfront|xiino|vodafone|portalmmm|sagem|mot-|sie-|ipod|up\\.b|' \
                         'webos|amoi|novarra|cdm|alcatel|pocket|iphone|mobileexplorer|mobile'
  def mobile?
    agent_str = request.user_agent.to_s.downcase
    return false if agent_str =~ /ipad/
    agent_str =~ Regexp.new(MOBILE_USER_AGENTS)
  end

  def pc?
    return !(mobile?)
  end

  def parse(date_num_s)
    year = date_num_s[0..3].to_i || 2015
    month = date_num_s[4..6].to_i || 12
    dt = Date.new(year, month, 1)
    return dt
  end

  def n0(num)
    number_with_precision num, precision: 0, delimiter: ','
  end
  def n2(num)
    number_with_precision num, precision: 2, delimiter: ','
  end
  def nw(num)
    "#{num / 10000}万"
  end
  def nq(num)
    "千#{num * 1000}"
  end

end
