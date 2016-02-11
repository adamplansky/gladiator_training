require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
     @user = User.new(first_name: "Adam", surname:"Plansky", email: "adamplansky@gmail.com", password:"12eoij1p30josjdflksajdfl;", password_confirmation:"12eoij1p30josjdflksajdfl;")
   end

   test "should be valid" do
     assert @user.valid?
   end

   test "email address should be unique" do
     another_user = @user.dup
     another_user.email = another_user.email.upcase
     @user.save
     assert_not another_user.valid?
   end

   test "first name should be present" do
     @user.first_name = '                                  '
     assert_not @user.valid?
   end

   test "surname should be present" do
     @user.surname = '                                  '
     assert_not @user.valid?
   end

   test "email should be present" do
     @user.surname = '                                  '
     assert_not @user.valid?
   end

   test "email address should be saved in lowercase" do
     @user.email = "aDaMpLansky@gmail.com"
     @user.save
     assert_equal @user.reload.email, "aDaMpLansky@gmail.com".downcase
   end

   test 'email should accept valid email address' do
     valid_adresses = %w(adam-p_l.ansky@gmail.com adam@plansky.cz adam_plansky@gmail.com)
     valid_adresses.each do |email_address|
       @user.email = email_address
       assert @user.valid?, "#{email_address} should be valid"
     end
   end

   test 'email should not accept invalid email address' do
     invalid_adresses = %w(adamplansky@gm @plansky.cz)
     invalid_adresses.each do |email_address|
       @user.email = email_address
       assert_not @user.valid?, "#{email_address} should NOT be valid"
     end
   end

   test "first name should not be longer than 50 characters" do
     @user.first_name = 'a' * 100
     assert_not @user.valid?
   end

   test "surname should not be longer than 50 characters" do
     @user.surname = 'a' * 100
     assert_not @user.valid?
   end


end
