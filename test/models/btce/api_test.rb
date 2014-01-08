require 'test_helper'

class APITest < ActiveSupport::TestCase
  test "API has domain" do
    assert Btce::API::DOMAIN
  end
  test "API contains currency pairs" do
    assert Btce::API::CURRENCY_PAIRS
  end
  test "API contains currencies" do
    assert Btce::API::CURRENCIES
  end
  test "API contains methods" do
    assert Btce::API.new.api_methods
  end
end
