require 'test_helper'

class UserSignupTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  test "invalid signup information" do
  	get signup_path
  	assert_no_difference "User.count" do
  		post users_path, user: { name: "",
  														email: "user@invalid",
  														password: 							"foo",
  														password_confirmation: "bar" }
  													end
  													assert_template "users/new"
                            assert_select 'div#error_explanation'
                            assert_select 'div.alert.alert-danger'
  												end
                          
test "valid signup information" do
	get signup_path
	assert_difference "User.count", 1 do
		post_via_redirect users_path user: { name: "Example User",
																				email: "user@example.com",
																				password: "F00bar#",
																				password_confirmation: "F00bar#" }
																			end
																			assert_template "users/show"
                                      assert_not flash.empty?
																		end




end

