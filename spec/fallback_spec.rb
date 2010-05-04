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

describe Fallback do
  describe 'simple' do
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

  describe 'rewrite' do
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
end