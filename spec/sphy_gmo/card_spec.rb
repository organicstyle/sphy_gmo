require 'spec_helper'

SphyGmo.configure do |config|
  config.host = SPEC_CONF["host"]
  config.site_id = SPEC_CONF["site_id"]
  config.site_pass = SPEC_CONF["site_pass"]
  config.shop_id = SPEC_CONF["shop_id"]
  config.shop_pass = SPEC_CONF["shop_pass"]
end
