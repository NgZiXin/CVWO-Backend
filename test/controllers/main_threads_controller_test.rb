require "test_helper"

class MainThreadsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @main_thread = main_threads(:one)
  end

  test "should get index" do
    get main_threads_url, as: :json
    assert_response :success
  end

  test "should create main_thread" do
    assert_difference("MainThread.count") do
      post main_threads_url, params: { main_thread: { body: @main_thread.body, category: @main_thread.category, country: @main_thread.country, title: @main_thread.title, user_id: @main_thread.user_id } }, as: :json
    end

    assert_response :created
  end

  test "should show main_thread" do
    get main_thread_url(@main_thread), as: :json
    assert_response :success
  end

  test "should update main_thread" do
    patch main_thread_url(@main_thread), params: { main_thread: { body: @main_thread.body, category: @main_thread.category, country: @main_thread.country, title: @main_thread.title, user_id: @main_thread.user_id } }, as: :json
    assert_response :success
  end

  test "should destroy main_thread" do
    assert_difference("MainThread.count", -1) do
      delete main_thread_url(@main_thread), as: :json
    end

    assert_response :no_content
  end
end
