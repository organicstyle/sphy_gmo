require 'spec_helper'

describe SphyGmo::Card do
  before do
    @member_id = generate_id.to_s
    SphyGmo.configure do |config|
      config.host = SPEC_CONF["host"]
      config.site_id = SPEC_CONF["site_id"]
      config.site_pass = SPEC_CONF["site_pass"]
      config.shop_id = SPEC_CONF["shop_id"]
      config.shop_pass = SPEC_CONF["shop_pass"]
    end
  end

  #GMOペイメント会員登録
  describe "#Member.save" do
    it "gets data about a member" do
      member_id = @member_id
      member_name = "Foo Bar"
      SEQ_MODE = 0
      SphyGmo::Member.save!( member_id: member_id, member_name: member_name, seq_mode: SEQ_MODE )
      member = SphyGmo::Member.search!(member_id: member_id)
      expect(member["MemberName"]).to eq member_name
      expect(member["MemberID"]).to eq @member_id
    end
  end

  #無効なトークンでは登録できないことを確認
  describe "#Card.save" do
    it "gets data about a card" do
      expect do
        member_id = @member_id
        token = generate_token
        SphyGmo::Card.save!( member_id: member_id, token: token, default_flag: 1, seq_mode: SEQ_MODE )
      end.to raise_error(SphyGmo::APIError, '決済処理に失敗しました。もう一度カード番号を入力してください。 指定されたサイトIDと会員IDの会員が存在しません。 有効期限が指定されていません。 カード番号が指定されていません。')
    end
  end
end
