# == Schema Information
#
# Table name: users
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  email      :string(255)
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

require 'spec_helper'

describe User do
  @user = User.new(name: "Example User", email: "user@example.com",
                   password: "foobar", password_confirmation: "foobar")

  subject { @user }

  it { should respond_to(:name) }
  it { should respond_to(:email) }
  it { should respond_to(:password_digest)}
  it { should respond_to(:password)}
  it { should respond_to(:password_confirmation)}

  it { should be_valid}

  describe "When name is not present" do
    before { @user.name = " "}
    it { should_not be_valid}
  end

  describe "When name is too long" do
    before { @user.name = "a" * 51}
    it {should_not be_valid}
  end

  describe "when email format is invalid" do
    it "should be invalid" do
      addresses = %w[user@foo,com user_at_foo.org example.user@foo.]
      addresses.each do |invalid_address|
        @user.email = invalid_address
        @user.should_not be_valid
      end
    end
  end

  describe "when email format is valid" do
    it "should be valid" do
      addresses = %w[user@foo.com A_USER@f.b.org frst.lst@foo.jp a+b@baz.cn]
      addresses.each do |valid_address|
        @user.email = valid_address
        @user.should be_valid
      end
    end
  end

  describe "when email address is not unique" do
    before do
      user_with_same_email = @user.dup
      user_with_same_email = user_with_same_email.upcase
      user_with_same_email.save
    end

    it {should_not be_valid}
  end

  describe "when password is not present" do
    before {@user.password = @user.password_confirmation = " "}
    it {should_not be_valid}
  end

  describe "when password does not match confirmation" do
    before {@user.password_confirmation = "mismatch"}
    it {should_not be_valid}
  end

  describe "when password_confirmation isNil"
    before (@user.password_confirmation = nil)
    it {should_not be_valid}
end
