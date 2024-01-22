require "application_system_test_case"

class UserchatsTest < ApplicationSystemTestCase
  setup do
    @userchat = userchats(:one)
  end

  test "visiting the index" do
    visit userchats_url
    assert_selector "h1", text: "Userchats"
  end

  test "should create userchat" do
    visit userchats_url
    click_on "New userchat"

    fill_in "Message", with: @userchat.message
    fill_in "Resever", with: @userchat.resever
    fill_in "Sender", with: @userchat.sender
    fill_in "User", with: @userchat.user_id
    fill_in "Username", with: @userchat.username
    click_on "Create Userchat"

    assert_text "Userchat was successfully created"
    click_on "Back"
  end

  test "should update Userchat" do
    visit userchat_url(@userchat)
    click_on "Edit this userchat", match: :first

    fill_in "Message", with: @userchat.message
    fill_in "Resever", with: @userchat.resever
    fill_in "Sender", with: @userchat.sender
    fill_in "User", with: @userchat.user_id
    fill_in "Username", with: @userchat.username
    click_on "Update Userchat"

    assert_text "Userchat was successfully updated"
    click_on "Back"
  end

  test "should destroy Userchat" do
    visit userchat_url(@userchat)
    click_on "Destroy this userchat", match: :first

    assert_text "Userchat was successfully destroyed"
  end
end
