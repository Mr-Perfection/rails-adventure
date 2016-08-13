require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest
  
  def setup
    @user = users(:michael)
  end
  test "login with invalid information" do
    get login_path
    assert_template 'sessions/new'
    post login_path, params: { session: { email: "", password: "" } }
    assert_template 'sessions/new'
    assert_not flash.empty?
    get root_path
    assert flash.empty?
  end
  
  test "login with valid information" do
    get login_path
    post login_path, params: { session: { email:    @user.email,
                                          password: 'password' } }
    assert is_logged_in?
    assert_redirected_to @user
    follow_redirect!
    assert_template 'users/show'
    assert_select "a[href=?]", login_path, count: 0
    assert_select "a[href=?]", logout_path
    assert_select "a[href=?]", user_path(@user)
    delete logout_path  #destroy the session and redirect to root
    assert_not is_logged_in?  #error if it is logged in
    assert_redirected_to root_url #check if page has been moved to root_url
    follow_redirect!  #go to redirected page
    assert_select "a[href=?]", login_path #check if there is login path
    assert_select "a[href=?]", logout_path, count: 0  #check if there is no logout_path
    assert_select "a[href=?]", user_path(@user), count: 0 #pass if there is no logout_path
  end
end
