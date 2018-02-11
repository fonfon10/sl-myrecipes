require 'test_helper'

class ChefTest < ActiveSupport::TestCase


	def setup
		@chef = Chef.new(chefname: "mashrur", email: "mashrur@example.com")
		
	end


	test "chef should be valid" do
		assert @chef.valid?
	end

	test "name should be present" do
		@chef.chefname = " "
		assert_not @chef.valid?
	end

	test "name should be < 30 char" do
		@chef.chefname = "a" * 31
		assert_not @chef.valid?
	end

	test "email should be present" do
		@chef.email = " "
		assert_not @chef.valid?
	end
	test "email should not be too long" do
		@chef.email = "a" * 245 + "@example.com"
		assert_not @chef.valid?
	end

	test "email should be correct format" do
		valid_emails = %w[user@example.com mashrur@gmail.com M.first@yahoo.ca join+smith@co.uk.org]
		valid_emails.each do |valids|
			@chef.email = valids
			assert @chef.valid?, "#{valids.inspect} should be valid"
		end
	end
	test "email should reject invalid addresses" do
		invalid_emails = %w[mashrur@example mashrur@example,com mashrur.name@gmail. joe@bar+foo.com]
		invalid_emails.each do |invalids|
			@chef.email = invalids
			assert @chef.invalid?, "#{invalids.inspect} should be valid"
		end
	end

	

	test "email should be unique and case insensitive" do
		duplicate_chef = @chef.dup
		duplicate_chef.email = @chef.email.upcase
		@chef.save
		assert_not duplicate_chef.valid?
	end


	test "email should be case lowercase before hitting db" do
		mixed_email = "JohN@Example.com"
		@chef.email = mixed_email
		@chef.save
		assert_equal mixed_email.downcase, @chef.reload.email

	end



end

