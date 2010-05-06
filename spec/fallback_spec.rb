require 'spec/spec_helper'

class Shop < ActiveRecord::Base
end

class User < ActiveRecord::Base
  include Fallback
  has_one :shop
  fallback :name, :to => :shop
end

class User2 < ActiveRecord::Base
  include Fallback
  set_table_name :users
  has_one :shop
  fallback :name => :title, :to => :shop
end

class User3 < ActiveRecord::Base
  include Fallback
  set_table_name :users
  fallback :description => :detailed_description
end

class User4 < ActiveRecord::Base
  include Fallback
  set_table_name :users
  fallback :name => :description, :if => lambda{|u| u.xxx}
end

class User5 < ActiveRecord::Base
  include Fallback
  set_table_name :users
  fallback :name => :description, :if => :xxx
end


describe Fallback do
  describe 'without delegation' do
    it "uses current if current is present" do
      user = User3.new(:description => 'DESC', :detailed_description => 'OOOPS')
      user.description.should == 'DESC'
    end

    it "calls method if current is blank" do
      user = User3.new(:description => '  ', :detailed_description => 'DESC')
      user.description.should == 'DESC'
    end

    it "calls method if current is nil" do
      user = User3.new(:description => nil, :detailed_description => 'DESC')
      user.description.should == 'DESC'
    end
  end

  describe 'simple delegation' do
    it "uses current if current is present" do
      user = User.new(:name => 'NAME', :shop => Shop.new(:name => 'OOPS'))
      user.name.should == 'NAME'
    end

    it "calls method if current is blank" do
      user = User.new(:name => '  ', :shop => Shop.new(:name => 'NAME'))
      user.name.should == 'NAME'
    end

    it "calls method if current is nil" do
      user = User.new(:name => nil, :shop => Shop.new(:name => 'NAME'))
      user.name.should == 'NAME'
    end
  end

  describe 'delegation with rewrite' do
    it "uses current if current is present" do
      user = User2.new(:name => 'NAME', :shop => Shop.new(:title => 'OOPS'))
      user.name.should == 'NAME'
    end

    it "calls method if current is blank" do
      user = User2.new(:name => '  ', :shop => Shop.new(:title => 'TITLE'))
      user.name.should == 'TITLE'
    end

    it "calls method if current is nil" do
      user = User2.new(:name => nil, :shop => Shop.new(:title => 'TITLE'))
      user.name.should == 'TITLE'
    end
  end

  describe 'with lambda' do
    before do
      @user = User4.new(:name => 'N', :description => 'D')
    end

    it "asks lambda" do
      @user.should_receive(:xxx).and_return true
      @user.name
    end

    it "returns original if lambda returns false" do
      @user.stub!(:xxx).and_return false
      @user.name.should == 'N'
    end

    it "delegates if lambda returns true" do
      @user.stub!(:xxx).and_return true
      @user.name.should == 'D'
    end
  end

  describe 'with method as symbol' do
    before do
      @user = User5.new(:name => 'N', :description => 'D')
    end

    it "asks method" do
      @user.should_receive(:xxx).and_return true
      @user.name
    end

    it "returns original if method returns false" do
      @user.stub!(:xxx).and_return false
      @user.name.should == 'N'
    end

    it "delegates if method returns true" do
      @user.stub!(:xxx).and_return true
      @user.name.should == 'D'
    end
  end

  describe "without fallback" do
    it "can call original value" do
      user = User.new(:name => nil, :shop => Shop.new(:name => 'NAME'))
      user.name_without_fallback.should == nil
    end
  end

  it "has a VERSION" do
    Fallback::VERSION.should =~ /^\d+\.\d+\.\d+$/
  end
end