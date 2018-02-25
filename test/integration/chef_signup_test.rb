require 'test_helper'

class ChefSignupTest < ActionDispatch::IntegrationTest

	test "should get signup page" do
		get signup_path
		assert_response :success
	end


	test "rejest an invalid signup" do
		get signup_path
		assert_no_difference "Chef.count" do
			post chefs_path, params: {chef: {chefname: " ", email: " ", password: "password",
																			password_confirmation: " "} }
		end
		assert_template 'chefs/new'
		assert_select 'h2.panel-title'
		assert_select 'div.panel-body'

	end


	test "accept a valid signup" do
		get signup_path
		assert_difference "Chef.count" do
			post chefs_path, params: {chef: {chefname: "mashrur", email: "mashrur@example.com", password: "password",
																			password_confirmation: "password"} }
		end
		follow_redirect!
		assert_template 'chefs/show'
		assert_not flash.empty?

	end


end
