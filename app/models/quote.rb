require "oauth"
require "json"

class Quote < ActiveRecord::Base
  belongs_to :code

  class << self
    def tradeking_json_map
      {
        "adp_100" => "Average Daily Price - 100 day",
        "adp_200" => "Average Daily Price - 200 day",
        "adp_50" => "Average Daily Price - 50 day",
        "adv_21" => "Average Daily Volume - 21 day",
        "adv_30" => "Average Daily Volume - 30 day",
        "adv_90" => "Average Daily Volume - 90 day",
        "ask" => "Ask price",
        "ask_time" => "Time of latest ask",
        "asksz" => "Size of latest ask (in 100's)",
        "basis" => "Reported precision (quotation decimal places)",
        "beta" => "Beta volatility measure",
        "bid" => "Bid price",
        "bid_time" => "Time of latest bid",
        "bidsz" => "Size of latest bid (in 100's)",
        "bidtick" => "Tick direction since last bid",
        "chg" => "Change since prior day close (cl)",
        "chg_sign" => "Change sign", # (e, u, d) as even, up, down
        "chg_t" => "change in text format",
        "cl" => "previous close",
        "contract_size" => "contract size for option",
        "cusip" => "Cusip",
        "date" => "Trade date of last trade",
        "datetime" => "Date and time",
        "days_to_expiration" => "Days until option expiration date",
        "div" => "Latest announced cash dividend",
        "divexdate" => "Ex-dividend date of div(YYYYMMDD)",
        "divfreq" => "Dividend frequency", # A - Annual Dividend, S - Semi Annual Dividend, Q - Quarterly Dividend, M - Monthly Dividend, N - Not applicable or No Set Dividend Frequency."
        "divpaydt" => "Dividend pay date of last announced div",
        "dollar_value" => "Total dollar value of shares traded today",
        "eps" => "Earnings per share",
        "exch" => "exchange code",
        "exch_desc" => "exchange description",
        "hi" => "High Trade Price for the trading day",
        "iad" => "Indicated annual dividend",
        "idelta" => "Option risk measure of delta using implied volatility",
        "igamma" => "Option risk measure of gamma using implied volatility",
        "imp_volatility" => "Implied volatility of option price based current stock price",
        "incr_vl" => "Volume of last trade",
        "irho" => "Option risk measure of rho using implied volatility",
        "issue_desc" => "Issue description",
        "itheta" => "Option risk measure of theta using implied volatility",
        "ivega" => "Option risk measure of vega using implied volatility",
        "last" => "Last trade price",
        "lo" => "Low Trade Price for the trading day",
        "name" => "Company name",
        "op_delivery" => "Option Settlement Designation", # S Std N – Non Std X - NA
        "op_flag" => "Security has options", # (1=Yes, 0=No).
        "op_style" => "Option Style", # values are "A" American and "E" European
        "op_subclass" => "Option class", # (0=Standard, 1=Leap, 3=Short Term)
        "openinterest" => "Open interest of option contract",
        "opn" => "Open trade price",
        "opt_val" => "Estimated Option Value – via Ju/Zhong or Black-Scholes",
        "pchg" => "percentage change from prior day close",
        "pchg_sign" => "prchg sign", # (e, u, d) as even, up, down
        "pcls" => "Prior day close",
        "pe" => "Price earnings ratio",
        "phi" => "Prior day high value",
        "plo" => "Prior day low value",
        "popn" => "Prior day open",
        "pr_adp_100" => "Prior Average Daily Price '100' trade days",
        "pr_adp_200" => "Prior Average Daily Price '200' trade days",
        "pr_adp_50" => "Prior Average Daily Price '50' trade days",
        "pr_date" => "Trade Date of Prior Last",
        "pr_openinterest" => "Prior day's open interest",
        "prbook" => "Book Value Price",
        "prchg" => "Prior day change",
        "prem_mult" => "Option premium multiplier",
        "put_call" => "Option type (Put or Call)",
        "pvol" => "Prior day total volume",
        "qcond" => "Condition code of quote",
        "rootsymbol" => "Option root symbol",
        "secclass" => "Security class", # (0=stock, 1=option)
        "sesn" => "Trading session as (pre, regular, &amp, post)",
        "sho" => "Shares Outstanding",
        "strikeprice" => "Option strike price (not extended by multiplier)",
        "symbol" => "Symbol from data provider",
        "tcond" => "Trade condition code", # (H) halted or (R) resumed
        "timestamp" => "Timestamp",
        "tr_num" => "Number of trades since market open",
        "tradetick" => "Tick direction from prior trade", # – (e,u,d) even, up, down)
        "trend" => "Trend based on 10 prior ticks", # (e,u,d) even, up, down
        "under_cusip" => "An option's underlying cusip",
        "undersymbol" => "An option's underlying symbol",
        "vl" => "Cumulative volume",
        "volatility12" => "one year volatility measure",
        "vwap" => "Volume weighted average price",
        "wk52hi" => "52 week high",
        "wk52hidate" => "52 week high date",
        "wk52lo" => "52 week low",
        "wk52lodate" => "52 week low date",
        "xdate" => "Expiration date of option in the format of (YYYYMMDD)",
        "xday" => "Expiration day of option",
        "xmonth" => "Expiration month of option",
        "xyear" => "Expiration year of option",
        "yield" => "Dividend yield as %"
      }
    end

    def query_tradeking(symbols = nil)
      symbols ||= Code.all.map(&:symbol).join(",")
      consumer = OAuth::Consumer.new(Rails.application.secrets.consumer_key, Rails.application.secrets.consumer_secret, { site: "https://api.tradeking.com" })
      access_token = OAuth::AccessToken.new(consumer, Rails.application.secrets.oauth_token, Rails.application.secrets.oauth_token_secret)

      response = JSON.parse(access_token.get("/v1/market/ext/quotes.json?symbols=#{symbols}").body)
      response["response"]["quotes"]["quote"].each do |result|
        code = Code.find_by(symbol: result["symbol"])
        Quote.create(code: code, json: result)
      end
    end
  end
end
