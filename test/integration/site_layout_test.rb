require 'test_helper'

class SiteLayoutTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:michael)
  end
  
  test "layout links" do 
    get root_path
    assert_template 'static_pages/home'
    assert_select "a[href=?]", root_path, count: 2 #count verifies that there are two links: one for logo and another for nav menu item
    assert_select "a[href=?]", help_path
    assert_select "a[href=?]", about_path
    assert_select "a[href=?]", contact_path
    get contact_path
    assert_select "title", full_title("Contact")
    #when not logged in, it should redirect to login path
    get users_path
    assert_redirected_to login_path
    log_in_as(@user)
    get users_path
    assert_template 'users/index'
    assert_select "a[href=?]", users_path
    
    # assert_redirected_to login_path
  end
end
