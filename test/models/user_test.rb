require 'test_helper'

class UserTest < ActiveSupport::TestCase

  def setup
    @user =User.new(name: 'example user', email:'user@example.com',
                    password: 'foobar', password_confirmation: 'foobar')

  end
  test 'should be valid' do
    assert @user.valid?

  end

  test 'name should be present' do
    @user.name = "  "
    assert_not @user.valid?
  end

  test 'name should not be too long' do
    @user.name = "a"*51
    assert_not @user.valid?
  end

  test 'email should not be too long' do
    @user.email = 'a'*244 + '@example.com'
    assert_not @user.valid?
  end

  test 'email validation should accept valid address' do
    valid_addresses = %w(user@example.com USER@foo.COM A_US-ER@foo.bar.org
                         first.last@foo.jp alice+bob@baz.cn)
    valid_addresses.each do |valid_address|
      @user.email =valid_address
      assert @user.valid?, "#{valid_address.inspect} should be valid"   #test  msg
    end

  end

  test 'email validation should reject invalid address' do
    invalid_addresses = %w(user@example,com  alice@baz+bob.cn foo@bar..com)
    invalid_addresses.each do |invalid_address|
      @user.email =invalid_address
      assert_not @user.valid?, "#{invalid_address.inspect} should be invalid"   #test  msg
    end

  end

  test 'email should be unique' do
    @user.email.upcase
    duplicate_user =@user.dup
    @user.save
    assert_not duplicate_user.valid?,"duplicate_user should be invalid"

  end

  test 'password should be present (nonblank)' do
    @user.password =@user.password_confirmation = " " * 6
    assert_not @user.valid?
  end

  test 'password should hava a minimum length' do
    @user.password =@user.password_confirmation = "a" * 5
    assert_not @user.valid?
  end
end
