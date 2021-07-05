require "test_helper"

class StoreControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get store_index_url
    assert_response :success
    assert_select '#columns #side a', minimum: 4 #check minimum of 4 links
    assert_select "#main .entry", 3 #check the 3 elements with classname entry inside  
    assert_select "h3", "Programming Ruby 1.9"
    assert_select ".price", /\$[,\d]+\.\d\d/
  end


end
