require 'spec_helper'
require 'yaml'

settings = YAML.load_file("settings.yml")

SphyGmo.configure do |config|
  config.host = settings["GMO_HOST"]
  config.site_id = settings["GMO_SITE_ID"]
  config.site_pass = settings["GMO_SITE_PASS"]
  config.shop_id = settings["GMO_SHOP_ID"]
  config.shop_pass = settings["GMO_SHOP_PASS"]
end
