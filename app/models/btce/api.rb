module Btce
  class API
    # https://hdbtce.kayako.com/Knowledgebase/List/Index/4/api
    DOMAIN = "btc-e.com"
    CURRENCY_PAIRS = %w(
      btc_usd btc_eur btc_rur eur_usd ftc_btc
      ltc_btc ltc_eur ltc_rur ltc_usd nmc_btc
      nmc_usd nvc_btc nvc_usd ppc_btc ppc_usd
      trc_btc usd_rur xpm_btc)
    CURRENCIES = CURRENCY_PAIRS.map {|pair| pair.split("_")}.flatten.uniq.sort
    PARAMETER_DISPLAY_NAME = {
      "pair" => "Pair",
      "type" => "Type",
      "amount" => "Amount",
      "rate" => "Rate",
      "timestamp_created" => "Created",
      "status" => "Status",
      "id" => "id",
      "currency" => "Currency",
      "desc" => "Description",
      "timestamp" => "Timestamp",
      "order_id" => "OrderID",
      "is_your_order" => "your order" }
    def api_methods
      self.class.instance_methods(false)
    end
  end
end
