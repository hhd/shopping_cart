require 'test_helper'

class CartMailerTest < ActionMailer::TestCase
  test "thankyou" do
    @expected.subject = 'CartMailer#thankyou'
    @expected.body    = read_fixture('thankyou')
    @expected.date    = Time.now

    assert_equal @expected.encoded, CartMailer.create_thankyou(@expected.date).encoded
  end

end
