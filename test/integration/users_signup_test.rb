require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end

  test 'invalid signuo infromation' do
    get signup_path
    assert_no_difference 'User.count' do
      post users_path, params:{
          user:{
              name:'',
              email:'user@invalid',
              password:'foo',
              password_confirmation:'bar'
          }
      }
      assert_template 'users/new'

      assert_select "form[action=?]",'/signup'
    end
  end


  test 'valid signup information' do

    get signup_path
    assert_difference 'User.count', 1 do
      post users_path, params:{ user:{
          name: 'Example User',
          email: 'user@example.com',
          password: 'password',
          password_confirmation: 'password'}
      }
      follow_redirect!
      assert_template 'users/show'
      assert_not flash.message
    end
  end
end
