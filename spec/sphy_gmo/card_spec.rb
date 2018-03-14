require 'spec_helper'
require 'i18n'

I18n.backend.load_translations(Dir.glob('locales/ja.yml'))
I18n.default_locale = :ja

describe SphyGmo::Card do
  before do
    SphyGmo.configure do |config|
      config.host = ENV['MANATSUKU_GMO_HOST']
      config.site_id = ENV['MANATSUKU_GMO_SITE_ID']
      config.site_pass = ENV['MANATSUKU_GMO_SITE_PASS']
      config.shop_id = ENV['MANATSUKU_GMO_SHOP_ID']
      config.shop_pass = ENV['MANATSUKU_GMO_SHOP_PASS']
    end
  end

  #GMOペイメント会員登録
  describe "#Member.save" do
    let(:member_id) { generate_id.to_s }
    it "gets data about a member" do
      member_name = "Foo Bar"
      SEQ_MODE = 0
      SphyGmo::Member.save!( member_id: member_id, member_name: member_name, seq_mode: SEQ_MODE )
      member = SphyGmo::Member.search!(member_id: member_id)
      expect(member).to include("MemberID" => member_id, "MemberName" => member_name, "DeleteFlag" => "0")
    end
  end

  #無効なトークンでは登録できないことを確認
  describe "#Card.save" do
    let(:member_id) { generate_id.to_s }
    it "gets data about a card" do
      error_code = I18n.t :token_error
      expect do
        token = generate_token
        SphyGmo::Card.save!( member_id: member_id, token: token, default_flag: 1, seq_mode: SEQ_MODE )
      end.to raise_error(SphyGmo::APIError, error_code)
    end

  end
end
