require 'test_helper'

class ShopsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get shops_index_url
    assert_response :success
  end

  test "should get show" do
    get shops_show_url
    assert_response :success
  end

  test "should get new" do
    get shops_new_url
    assert_response :success
  end

  test "should get edit" do
    get shops_edit_url
    assert_response :success
  end

end
