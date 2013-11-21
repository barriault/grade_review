require 'spec_helper'

describe User do

  describe '#email' do
    it "is invalid when nil" do
      user = build(:user, email: nil)
      expect(user).to be_invalid
    end

    it "is invalid when empty" do
      user = build(:user, email: "")
      expect(user).to be_invalid
    end
    
    it "is valid with a valid email address" do
      addresses = %w[user@foo.com THE_USER@foo.bar.org first.last@foo.jp]
      addresses.each do |address|
        user = build(:user, email: address)
        expect(user).to be_valid
      end
    end
    
    it "is invalid with an invalid email address" do
      addresses = %w[user@foo,com user_at_foo.org example.user@foo.]
      addresses.each do |address|
        user = build(:user, email: address)
        expect(user).to be_invalid
      end
    end

    it "is invalid with a duplicate email addresses" do
      user = create(:user)
      expect(build(:user, email: user.email)).to be_invalid
    end

    it "is invalid with email addresses identical up to case" do
      user = create(:user)
      upcased_email = user.email.upcase
      expect(build(:user, email: upcased_email)).to be_invalid
    end
  end
  
  describe '#name' do
    it 'is invalid when nil'
    it 'is invalid when empty'
    it 'is invalid when duplicate'
  end
  
  describe '#uid' do
    it 'is invalid when nil'
    it 'is invalid when empty'
    it 'is invalid when duplicate'
  end

end
