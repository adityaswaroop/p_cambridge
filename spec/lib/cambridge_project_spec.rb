require 'spec_helper'
require 'cambridge_project'

describe Array do

  it 'should behave like array#map to_s' do
    a = [1, 2, 3, 4]
    expect(a.my_map(&:to_s)).to eq(%w{1 2 3 4})
  end

  it 'should behave like array#map increament by 1' do
    a = [1, 2, 3, 4]
    expect(a.my_map{ |x| x + 1 } ).to eq( [2, 3, 4, 5] )
  end

  it 'should behave like array#sort' do
    a = [7, 2, 3, 4]
    expect(a.sort_arr).to eq([2, 3, 4, 7])
  end

end

describe DesignHash do

  it 'should parse the given hash' do
    hash = {"properties"=> {"user_id"=>43,"managing_user_id"=>43,"description"=>"Push Notification", "effective_date"=>"2015-07-20T06:28:36-05:00", "system_date"=>"2015-07-20T06:28:36-05:00"}, "payload"=>{"id"=> 49, "options"=> {"devices"=> "ios => e25454608b6097bc412be42ad9bf39797a698925d947b9d136cbb992f649cc96", "Alert_message"=> " You have following notifications ", "badge_count"=>10, "created_at"=>"2015-07-20T06:28:36-05:00", "id"=>48, "member_id"=>25, "notification_type"=> "secure_message", "silent"=>true, "updated_at"=>"2015-07-20T06:28:36-05:00" }}}

    dh= DesignHash.new
    new_hash = dh.convert_hash(hash)
    new_hash_expected = {:payload=>{:user_id=>43, :message=>"You have 10 notifications", :message_type=>"secure_message", :pop_up=>true, :publish_at=>"2015-07-20T06:28:36-05:00", :target=>"gsm", :device_id=>"e25454608b6097bc412be42ad9bf39797a698925d947b9d136cbb992f649cc96"}}
    expect(new_hash).to eq(new_hash_expected)
  end

end