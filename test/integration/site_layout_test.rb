require 'test_helper'

class SiteLayoutTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:paul)
    @other_user = users(:archer)
  end

  test "layout_links" do
  	get root_path
  	assert_template 'static_pages/home'
  	assert_select 'a[href= ?]', root_path, count: 2
  	assert_select 'a[href= ?]', about_path
  	assert_select 'a[href= ?]', help_path
  	assert_select 'a[href= ?]', contact_path 
    get  signup_path
    assert_select "title", full_title("Sign Up")
  end

  test "get layout_links when logged in" do
    log_in_as(@user)
    get root_path
    assert_template 'layouts/_header'
    assert_select 'a[href=?]', root_path, count: 2
    assert_select 'a[href=?]', about_path
    assert_select 'a[href=?]', help_path
    assert_select 'a[href=?]', contact_path
    assert_select 'a[href=?]', edit_user_path(@user)
    assert_select 'a[href=?]', logout_path
    assert_select 'a[href=?]', users_path
    assert_template 'layouts/_shim'
    assert_template 'layouts/_footer'
    assert_select 'a[href=?]', about_path
    assert_select 'a[href=?]', contact_path
    assert_select 'a[href="http://news.railstutorial.org/"]' 
    assert_template 'layouts/application'
  end


end
