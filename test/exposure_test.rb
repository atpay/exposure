require 'test_helper'

class ExposureTest < ActiveSupport::TestCase
  def test_new_exposure
    signup = SimpleSignup.new(:email => "test@localhost")
    assert signup.valid?
  end

  def test_create_exposure
    assert_difference "User.count" do
      SimpleSignup.create(:email => "test@localhost")
    end
  end

  def test_table_name
    assert_equal "users", SimpleSignup.table_name
  end
end

class ExposureRoutingTest < ActionView::TestCase
  def test_create_route
    assert_equal "/simple_signups", url_for(SimpleSignup.new)
  end

  def test_show_route
    signup = SimpleSignup.create(:email => "test@localhost")
    assert_equal "/simple_signups/#{signup.id}", url_for(signup)
  end
end
