# frozen_string_literal: true

require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
  end

  # test "should get index" do
  #   get users_url
  #   assert_response :success
  # end

  # test "should get new" do
  #   get new_user_url
  #   assert_response :success
  # end

  test 'should create user' do
    assert_difference('User.count') do
      post users_url,
           params: { user_form: { email: 'newuser@example.com', name: @user.name, password: User::DEFAULT_PASS,
                                  password_confirmation: User::DEFAULT_PASS } }
    end

    assert_redirected_to users_url(locale: I18n.locale)
  end

  # test "should show user" do
  #   get user_url(@user)
  #   assert_response :success
  # end

  # test "should get edit" do
  #   get edit_user_url(@user)
  #   assert_response :success
  # end

  # test "should update user" do
  #   patch user_url(@user), params: { user: {
  # email: @user.email,
  # name: @user.name,
  # password: User::DEFAULT_PASS,
  # password_confirmation: User::DEFAULT_PASS} }

  #   assert_redirected_to users_url(@user, locale: I18n.locale)
  # end

  # test "should destroy user" do
  #   assert_difference('User.count', -1) do
  #     delete user_url(@user)
  #   end

  #   assert_redirected_to users_url
  # end
end
