require 'wombat'
require 'mechanize'
require 'multi_json'
require 'iconv'
require '../model/stock_short_term_info'
require '../db_connect'
class StockDayInfoCrawler
  # attr_accessor :url,:industry
  def initialize(client)
    @client=client
  end

  def crawl_stock_day_info(url, industry)
    page = @client.get(url, :headers => {'Content-Type' => 'text/plain; charset=gb2312'})
    result = Iconv.conv('utf-8', "gb2312", page.body).gsub(/([a-z]+):/, '"\1":')
    stocks_json = MultiJson.load(result)
    if result.include? "null" || stocks_json.length<=0
      return false
    end
    for i in 0...sina_industries.length-1
      stocks_json[i]["industry"]=industry
    end
    stocks = StockShortTermInfo.create(stocks_json)
    sleep(rand(3000)+1000)
    true
  end
end

# http://vip.stock.finance.sina.com.cn/quotes_service/api/json_v2.php/Market_Center.getHQNodeData?page=3&num=40&sort=symbol&asc=1&node=new_swzz&symbol=&_s_r_a=page