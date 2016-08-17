require 'test_helper'

class UsersEditTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:michael)
  end
  
  test "unsuccessful edit" do
    log_in_as(@user)
    get edit_user_path(@user)
    assert_template 'users/edit'
    
    patch user_path(@user), params: { user: {  name: "",
                                              email: "stephn@invalid",
                                              password: "foo",
                                              password_confirmation: "fur"
                                            }}  #test with the unsuccessful edit form returns success
    assert_template 'users/edit'
  end
  
  test "successful edit" do
    log_in_as(@user)
    get edit_user_path(@user)
    assert_template 'users/edit'
    name  = "Foo Bar"
    email = "foo@bar.com"
    patch user_path(@user), params: { user: { name:  name,
                                              email: email,
                                              password:              "",
                                              password_confirmation: "" } }
    assert_not flash.empty?
    assert_redirected_to @user
    @user.reload
    assert_equal name,  @user.name
    assert_equal email, @user.email
  end
  
  # test the friendly forwarding
  test "successful edit with friendly forwarding url" do
    
    get edit_user_path(@user)
    assert session[:forwarding_url]
    # assert_equal edit_user_path(@user), session[:forwarding_url]
    log_in_as(@user)
    assert_redirected_to edit_user_path(@user)
    assert_not session[:forwarding_url]  #after redirected to the edit, :forwarding_url should be null
    name = "Stephen Lee"
    email= "stpehen@gmail.com"
    patch user_path(@user), params: { user: { name:  name,
                                              email: email,
                                              password:              "",
                                              password_confirmation: "" } }
    assert_not  flash.empty?
    assert_redirected_to @user
    @user.reload
    assert_equal name,  @user.name
    assert_equal email, @user.email
  
    
    
  end
  
end
