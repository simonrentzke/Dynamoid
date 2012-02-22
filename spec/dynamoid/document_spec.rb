require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe "Dynamoid::Document" do

  it 'initializes a new document' do
    @address = Address.new
    
    @address.new_record.should be_true
    @address.attributes.should == {:id => nil, :city => nil}
  end
  
  it 'initializes a new document with attributes' do
    @address = Address.new(:city => 'Chicago')
    
    @address.new_record.should be_true
    
    @address.attributes.should == {:id => nil, :city => 'Chicago'}
  end
  
  it 'creates a new document' do
    @address = Address.create(:city => 'Chicago')
    
    @address.new_record.should be_false
    @address.id.should_not be_nil
  end
  
  it 'tests equivalency with itself' do
    @addres.should == @address
  end
  
  it 'is not equivalent to another document' do
    @address.should_not == Address.create
  end
  
  it 'is not equivalent to another object' do
    @address.should_not == "test"
  end
end
