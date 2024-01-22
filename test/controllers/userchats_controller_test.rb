require "test_helper"

class UserchatsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @userchat = userchats(:one)
  end

  test "should get index" do
    get userchats_url
    assert_response :success
  end

  test "should get new" do
    get new_userchat_url
    assert_response :success
  end

  test "should create userchat" do
    assert_difference("Userchat.count") do
      post userchats_url, params: { userchat: { message: @userchat.message, resever: @userchat.resever, sender: @userchat.sender, user_id: @userchat.user_id, username: @userchat.username } }
    end

    assert_redirected_to userchat_url(Userchat.last)
  end

  test "should show userchat" do
    get userchat_url(@userchat)
    assert_response :success
  end

  test "should get edit" do
    get edit_userchat_url(@userchat)
    assert_response :success
  end

  test "should update userchat" do
    patch userchat_url(@userchat), params: { userchat: { message: @userchat.message, resever: @userchat.resever, sender: @userchat.sender, user_id: @userchat.user_id, username: @userchat.username } }
    assert_redirected_to userchat_url(@userchat)
  end

  test "should destroy userchat" do
    assert_difference("Userchat.count", -1) do
      delete userchat_url(@userchat)
    end

    assert_redirected_to userchats_url
  end
end
