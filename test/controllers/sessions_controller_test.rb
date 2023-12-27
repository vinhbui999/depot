# frozen_string_literal: true

require 'test_helper'

class SessionsControllerTest < ActionDispatch::IntegrationTest
  test 'should prompt for login' do
    get login_url
    assert_response :success
  end

  test 'should login' do
    dave = users(:one)
    post login_url(locale: I18n.locale), params: { email: dave.email, password: User::DEFAULT_PASS }
    assert_redirected_to users_url(locale: I18n.locale)
    assert_equal dave.id, session[:user_id]
  end

  test 'should fail login' do
    dave = users(:one)
    post login_url(locale: I18n.locale), params: { email: dave.email, password: 'wrong' }
    assert_redirected_to login_url(locale: I18n.locale)
  end

  test 'should logout' do
    delete logout_url
    assert_redirected_to store_index_url(locale: I18n.locale)
  end
end
