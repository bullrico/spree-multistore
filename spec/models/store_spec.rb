require File.dirname(__FILE__) + '/../spec_helper'

describe Store do
  before(:each) do
    @store = Store.new
  end

  it "should be valid" do
    @store.should be_valid
  end
end
