require 'test_helper'

class UsersIndexTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  def setup
    @user = users(:michael)
    @admin = users(:michael)
    @non_admin = users(:archer)
    @inactive = users(:lora)
  end
  
  test "index including pagination" do
    log_in_as(@user)
    get users_path
    assert_template 'users/index'
    assert_select 'div.pagination'
    User.paginate(page: 1).each do |user|
      assert_select "a[href=?]", user_path(user), text: user.name
    end
  end
  
  test "index as admin including pagination" do
    log_in_as(@admin)
    get users_path
    assert_template 'users/index'
    assert_select 'div.pagination'
    first_page_of_users = User.paginate(page: 1)
    first_page_of_users.each do |user|
      assert_select "a[href=?]", user_path(user), text: user.name
      unless user == @admin
        assert_select "a[href=?]", user_path(user), text: 'delete'
      end
    end
  end
  
  test "index as non-admin" do
    log_in_as(@non_admin)
    get users_path
    assert_template 'users/index'
    assert_select 'a', text: 'delete', count: 0
  end
  
  test "show without activation and with activation" do
    @inactive.activated = false
    log_in_as(@inactive)
    get user_path(@inactive)
    assert_template '/'
    @inactive.activated = true
    get user_path(@inactive)
    assert_template 'users/show'
  end
  
end
