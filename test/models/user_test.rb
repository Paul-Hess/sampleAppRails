require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  def setup 
  	@user = User.new(name: "Example User", email: "foo@Example.com",
  	password: "F66#fdd", password_confirmation: "F66#fdd" )
  end

  test "should be valid" do
  	assert @user.valid?
  end

  test "username should be present" do
  	@user.name = "     "
  	assert_not @user.valid?
  end

  test "email should be present" do
  	@user.email = "    "
  	assert_not @user.valid?
  end

  test "name should not be too long" do
  	@user.name = "a" * 51
  	assert_not @user.valid?
  end

  test "email should not be too long" do
  	@user.email = "a" * 244 + "@example.com"
  	assert_not @user.valid?
  end

  test "email validation should accept valid addresses" do
  	valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org first.last@foo.jp alice+bob@baz.cn]
  	valid_addresses.each do |valid_address|
  		@user.email = valid_address
  		assert @user.valid?, "@{valid_address.inspect} should be valid"
  	end
  end

  test "email validation should reject invalid addresses" do 
  	invalid_addresses = %w[user@example,com user_at_foo.org user.name@example. foo@bar_baz.com foo@bar+baz.com]
  	invalid_addresses.each do |invalid_address|
  		@user.email = invalid_address 
  		assert_not @user.valid?, "#{invalid_address.inspect} should be invalid"
  	end
  end

  test "email should be unique" do
  	duplicate_user = @user.dup
  	duplicate_user.email = @user.email.upcase
  	@user.save
  	assert_not duplicate_user.valid?
  end

  test "email should addresses should be saved as lowercase" do
  	mixed_case_email = "FoO@ExamPlE.COM"
  	@user_email = mixed_case_email
  	@user.save
  	assert_equal mixed_case_email.downcase, @user.reload.email
  end

  test "should save user params" do
    @user = User.new
    assert_not_nil?(@user.attributes) if @user.save
  end

   test "password should be present (nonblank)" do
    @user.password = @user.password_confirmation = " " * 6
    assert_not @user.valid?
  end

  test "password should have a minimum length" do
    @user.password = @user.password_confirmation = "a" * 5
    assert_not @user.valid?
  end

  test "Authenticated? should return false for a user with nil digest" do
    assert_not @user.authenticated?(:remember, '')
  end

  test "associated microposts should be destroyed" do 
    @user.save 
    @user.microposts.create!(content: "Lorem Ipsum")
    assert_difference "Micropost.count", -1 do 
      @user.destroy
    end
  end

  test "should follow and unfollow a user" do 
    paul = users(:paul)
    archer = users(:archer)
    assert_not paul.following?(archer)
    paul.follow(archer)
    assert paul.following?(archer)
    assert archer.followers.include?(paul), message
    paul.unfollow(archer)
    assert_not paul.following?(archer)
  end

  test "feed should have the right posts" do  
    paul = users(:paul)
    archer = users(:archer)
    lana = users(:lana)
    # Posts form a followed user
    lana.microposts.each do |post_following|
      assert paul.feed.include?(post_following)
    end
    # Posts from self
    paul.microposts.each do |post_self|
      assert paul.feed.include?(post_self)
    end
    # Posts from unfollowed user
    archer.microposts.each do |post_unfollowed|
      assert_not paul.feed.include?(post_unfollowed)
    end
  end



end    









