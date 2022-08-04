require "test_helper"

class GuessControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get guess_index_url
    assert_response :success
  end

  test "should get new" do
    get guess_new_url
    assert_response :success
  end

  test "should get show" do
    get guess_show_url
    assert_response :success
  end

  test "should get create" do
    get guess_create_url
    assert_response :success
  end

  test "should get edit" do
    get guess_edit_url
    assert_response :success
  end
end
