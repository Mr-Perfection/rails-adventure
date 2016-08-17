require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  
  def setup
    @user       = users(:michael)
    @other_user = users(:archer)
  end
  
  test "should get new" do
    get signup_path
    assert_response :success
  end
  

  test "should redirect edit when not logged in" do   #test authorization for invalid access
    get edit_user_path(@user)
    assert_not flash.empty? #success if there is no flash
    assert_redirected_to login_url
  end
  
  test "should redirect update when not logged in" do   #test authorization for invalid access
    patch user_path(@user), params: { user: { name:  @user.name,
                                              email: @user.email } }
    assert_not flash.empty?
    assert_redirected_to login_url
  end
  
  test "should redirect edit when logged in as wrong user" do #test authorizastion for wrong user
    log_in_as(@other_user)
    get edit_user_path(@user)
    assert flash.empty? #should not be empty. logged in as different user!
    assert_redirected_to root_url
  end
  
  test "should redirect update when logged in as wrong user" do #test authorizastion for wrong user
    log_in_as(@other_user)
    patch user_path(@user), params: { user: { name:  @user.name,
                                              email: @user.email } }
    assert flash.empty? #should not be empty. logged in as different user!
    assert_redirected_to root_url
  end
end
